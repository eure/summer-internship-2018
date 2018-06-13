import React from 'react';
import PropTypes from 'prop-types';

import TrendRow from './TrendRow';
import TrendsClickableBtn from './TrendsClickableBtn';

// トレンドリストを扱うコンポーネント
const TrendsTable = ({ trends, sortKey, onSort }) => (
  <div className="trends-items">
    <div className="sort-section-title">Sort</div>
    <TrendsClickableBtn
      label='star'
      sortKey={sortKey}
      onSort={key => onSort(key)}
    />
    <TrendsClickableBtn
      label='fork'
      sortKey={sortKey}
      onSort={key => onSort(key)}
    />
    {trends.map(trend => (<TrendRow key={trend.id} trend={trend} />))}
  </div>
);

TrendsTable.propTypes = {
  trends: PropTypes.arrayOf(PropTypes.any),
  sortKey: PropTypes.string.isRequired,
  onSort: PropTypes.func.isRequired,
};

TrendsTable.defaultProps = {
  trends: [],
};

export default TrendsTable;