/**
* @returns {any}
*/

const subs = {
  commit_comment: 'comment',
  issues: 'issue',
  pull_request: 'pull_request',
  pull_request_review: 'review',
  pull_request_review_comment: 'comment',
  push: 'head_commit'
};

module.exports = (context, callback) => {
  let team_id = 'T07KSCKCM';
  let res_url = 'https://hooks.slack.com/services/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';

  let params = context.params;
  let headers = context.headers;
  let message = 'what ever event';
  let send = true;
  let event = null;

  if (headers && headers['x-github-event']) {
    event = headers['x-github-event'];
  }


  if(!event) return callback(null,'Wrong Format',{});


  let repository = params.repository;
  let sub = params[subs[event]];
  if (!repository || !sub) return callback(null,'Missings',{});

  let action = params.action

  let repo = repository.full_name;
  let repo_url = repository.html_url;

  let sub_url = sub.html_url;
  let number = sub.number;
  let title = sub.title;
  let body = sub.body;

  let user = sub.user;
  let by = user ? user.login : '';
  let user_url = user ? user.html_url : '';

  if (event === 'push') {
    let compare = params.compare;
    let nCommit = params.commits.length;
    let author0 = params.head_commit.author.name;
    let authors = {}
    params.commits.map(commit => {
      authors[commit.author.name] = 1
    });
    let nAuthorsExcept = authors.length-1;
    let authorText = author0 + (nAuthorsExcept>0 ? ` and ${nAuthors} others` : '');
    let branch = params.ref.split('/').reverse()[0];
    let commits = 'commit' + (nCommit > 1 ? 's' : '');
    message = {
      attachments: [
        {
          color: '#4782C9',
          text: `<${repo_url}|[${repo}:${branch}]> <${compare}|${nCommit} 의 커밋>이 **PUSH** 되었습니다. 와우~ :+1: by ${authorText}`,
          mrkdwn_in: ["text", "pretext"]
        }
      ]
    };
  } else if (event === 'issues') {
    let title = params.issue.title;
    message = {
      attachments: [
        {
          pretext: `${repo_url}|[${repo}]> Issue ${action} by <${user_url}|${by}>`,
          color: 'ED9700',
          text: `<${sub_url}|#${number} ${title}>`,
          mrkdwn_in: ["text", "pretext"]
        }
      ]
    };
  } else if (event === 'commit_comment') {
    let c = params.comment;
    let commit = c.commit_id.substring(0,7)
    let body = c.body
    message = {
      attachments: [
        {
          pretext: `<${repo_url}|[${repo}]> New <${sub_url}|comment> by ${by} on commit \`${commit}\``,
          color: '#C7DAEF',
          text: body,
          mrkdwn_in: ["text", "pretext"]
        }
      ]
    };
  } else if (event === 'pull_request') {
    message = {
      attachments: [
        {
          pretext: `<${repo_url}|[${repo}]> Pull request ${action} by <${user_url}|${by}>`,
          color: '#79C616',
          title: `<${sub_url}|#${number} ${title}>`,
          mrkdwn_in: ["text", "pretext"]
        }
      ]
    };
  } else if (event === 'pull_request_review') {
    message = {
      attachments: [
        {
          pretext: `<${repo_url}|[${repo}]> Pull Request Review ${action} by <${user_url}|${by}>`,
          color: '#79C616',
          text: `<${sub_url}|${body}>`,
          mrkdwn_in: ["text", "pretext"]
        }
      ]
    };
  } else if (event === 'pull_request_review_comment') {
    message = {
      attachments: [
        {
          pretext: `<${repo_url}|[${repo}]> Pull Request Review Comment ${action} by <${user_url}|${by}>`,
          color: '#79C616',
          text: `<${sub_url}|${body}>`,
          mrkdwn_in: ["text", "pretext"]
        }
      ]
    };
  }

  if (send === true) {
    // callback(err, res, data)
    callback(null, 'ok', {
      message: message
    })
  } else {
    callback(null,'ok',{});
  }
};
