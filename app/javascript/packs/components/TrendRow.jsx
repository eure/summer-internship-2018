import React from 'react';
import PropTypes from 'prop-types';

const TrendRow = ({ trend }) => (
  <div className="trends-index-item">
    <div className="trend-right">
      <div className="repositorie">
        <a href={"/trends/repository/?user="+(trend.title.split("/")[0])+"&repository="+(trend.title.split("/")[1])}>{trend.title}</a>
      </div>
      <div className="info">
        <div className="language">{trend.language}</div>
        <div className="star">star:{trend.star}</div>
        <div className="fork">fork:{trend.fork}</div>
      </div>
    </div>
  </div>
);

TrendRow.propTypes = {
  trend: PropTypes.shape({
    title: PropTypes.string,
    language: PropTypes.string,
    star: PropTypes.number,
    fork: PropTypes.number,
  }).isRequired,
};

export default TrendRow;