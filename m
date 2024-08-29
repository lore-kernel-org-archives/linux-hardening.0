Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0372B9CD
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930218; cv=none; b=Nq2+0rHkOQWgUEDBz12nXlxbpFUQkH2UN6Ri13E0nD932NJ4T0qsyaUeoBkJE14PeEyHN5iQZ8+XQJ/1JBA4Ee+F2Mh+VpUzhvpwvG7pJk4BgJlZ2Lvw5YhURJpbxCB58jl5p+YRQ2roojiJkG3DFmx9YBl883+KgeKj/UQ2Vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930218; c=relaxed/simple;
	bh=lbT8wY1WLNTiEqM372mxT1DNFh6kMW+/tis5jCTR4p0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSE3Jd28zqTy96BVbZwcIV8BMR4QtSD7KgkLqmP3PTg2Ihxd8pv0zEA0d1bYJstRhIiwOeVXzufeNdEfA9eTvv+ODqcQFXHHAlrqjmlZEWqUPZ1MZ24pUa3uhS7KgfXpuRADgtXy5Ic/jdtTvf77W597ZCbSG2W5Dv+RhQykblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wvdyf04JNz2Dbb4;
	Thu, 29 Aug 2024 19:16:42 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A3B921A0188;
	Thu, 29 Aug 2024 19:16:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 19:16:54 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next 1/2] coccinelle: Add rules to find str_true_false() replacements
Date: Thu, 29 Aug 2024 19:24:54 +0800
Message-ID: <20240829112455.232263-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829112455.232263-1-lihongbo22@huawei.com>
References: <20240829112455.232263-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

After str_true_false() has been introduced in the tree,
we can add rules for finding places where str_true_false()
can be used. A simple test can find over 10 locations.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c:910:40-44: opportunity for str_true_false(drop)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c:543:20-56: opportunity for str_true_false(conf -> flags & IEEE80211_CONF_MONITOR)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c:547:15-46: opportunity for str_true_false(conf -> flags & IEEE80211_CONF_PS)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c:718:15-35: opportunity for str_true_false(vif -> cfg . ibss_joined)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c:699:5-24: opportunity for str_true_false(info -> enable_beacon)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c:733:15-24: opportunity for str_true_false(info -> qos)
drivers/net/wireless/ath/ath9k/link.c:393:24-43: opportunity for str_true_false(common -> ani . caldone)
drivers/net/arcnet/com20020-pci.c:104:29-42: opportunity for str_true_false(lp -> backplane)
drivers/net/ethernet/intel/ice/ice_switch.c:2100:19-37: opportunity for str_true_false(params -> mask_valid)
drivers/net/wireless/ath/wil6210/interrupt.c:102:6-15: opportunity for str_true_false(mask_halp)
drivers/net/wireless/ath/wil6210/interrupt.c:154:6-17: opportunity for str_true_false(unmask_halp)
drivers/net/ethernet/intel/ice/ice_vlan_mode.c:257:6-24: opportunity for str_true_false(params -> mask_valid)
---
 scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 5e729f187f22..50329c4c8acd 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -85,3 +85,26 @@ e << str_down_up_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
+
+@str_true_false depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "true" : "false")
++      str_true_false(E)
+)
+
+@str_true_false_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "true" : "false")
+)
+
+@script:python depends on report@
+p << str_true_false_r.P;
+e << str_true_false_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
-- 
2.34.1

