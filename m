Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86327EC4;
	Tue,  4 Feb 2025 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637679; cv=none; b=s/3/jU8w1nxB8x68a6vR+Fd7ROT7c/HiBcBtfARPNoC4ZlgEcOEduSqt0II3QpG6UvvLl6aUuMdRt/jVcuOuvbqPe1qrqSkyrJeesAPpnNUyf8gQkeuK8WSg555H2QiJ84qvlIWaUYmp+clMsG5sQ2oRCElVrUBCVf4bpJzXwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637679; c=relaxed/simple;
	bh=Hr6eeyE9E3euEHL6VQuoN3igwKmYR486ysCJziX04tw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ajOnOeaWuWBzhLvG+GRUFV6wyIK8Z7yKfi3poe12byd9TmZqA5dMEODOUlfMaMApuwtmJQwdGcYyBbNU1pzU9Qn8xyR5A/x48KBefMDvs+ANfMCQcKkDTWnM/Xk3iT88aDhu1V9RwHm3keGUc6+ULluTZsoMtntZRTZnw/WAzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs5S3CSX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs5S3CSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311DEC4CEE2;
	Tue,  4 Feb 2025 02:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738637679;
	bh=Hr6eeyE9E3euEHL6VQuoN3igwKmYR486ysCJziX04tw=;
	h=Date:From:To:Cc:Subject:From;
	b=Gs5S3CSXcuLJ5Iuf2f5yaE4zMN4Z00DFYdT8QkkukJEwRcCkoKLnhCGyfP2906Zle
	 aWyrds+y4TQSC4wxEZVfScVgW0mw7hm2uMAgBHM5jaYj8E84pJ5NYLbdpSL6PcsKg6
	 Yk/FQs/xHbZT5nl6N0/G5I2J9ovOU3vFKiDcZx8hJMmZ/8P+psJ5wCkXDjha+TFbyV
	 JY/5On5vOnX/RiFWDy5AvBrcOXvWEgSgaFy3giq4hJspINKDgbkG9FRTIz+Nzt7Ayo
	 UuZA1DD+RTCTvmX9m81LpwT+/rLJNBJsxaHkcT4oqv+s7U74bMfYzlth18UuAXJ6ch
	 n9Q41nTvZUowQ==
Date: Tue, 4 Feb 2025 13:24:31 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] cxgb4: Avoid a -Wflex-array-member-not-at-end
 warning
Message-ID: <Z6GBZ4brXYffLkt_@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct ethtool_dump` is a flexible structure --a structure that
contains a flexible-array member.

Fix the following warning:
./drivers/net/ethernet/chelsio/cxgb4/cxgb4.h:1215:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update subject and prefix.
 - Add RB tag.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZrDx4Jii7XfuOPfC@cute/

 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index c7c2c15a1815..95e6f015a6af 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1211,9 +1211,6 @@ struct adapter {
 	struct timer_list flower_stats_timer;
 	struct work_struct flower_stats_work;
 
-	/* Ethtool Dump */
-	struct ethtool_dump eth_dump;
-
 	/* HMA */
 	struct hma_data hma;
 
@@ -1233,6 +1230,10 @@ struct adapter {
 
 	/* Ethtool n-tuple */
 	struct cxgb4_ethtool_filter *ethtool_filters;
+
+	/* Ethtool Dump */
+	/* Must be last - ends in a flex-array member. */
+	struct ethtool_dump eth_dump;
 };
 
 /* Support for "sched-class" command to allow a TX Scheduling Class to be
-- 
2.43.0

