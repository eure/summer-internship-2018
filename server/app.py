from flask import Flask, jsonify, abort, make_response
from flask_cors import CORS
import git_contorller


api = Flask(__name__)
CORS(api)

@api.route('/get', methods=['GET'])
def get():
    result = git.SearchGithubTrend()
    return make_response(jsonify(result))

@api.route('/detail', methods=['GET'])
def details():
    return make_response(git.GithubDetail())

    
@api.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not found'}), 404)


if __name__ == '__main__':
    api.run(host='0.0.0.0', port=3001)
