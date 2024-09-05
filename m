Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344E51974FE
	for <linux-hardening@vger.kernel.org>; Thu,  5 Sep 2024 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527835; cv=none; b=k3Kk0Lf7UlKivHEzm6U8ov6SpMAfaQr9CumxOqY1Evs2Qolhz/uzSmE9JCJm657r94/D22bWX3ZB8UV8wTycMG/CJ0yf3YDfwdtWH4wIIKCZC3sI8xu2Aem4KTlhDHX6h3V+EIN3YEGSOIuag+hwrhotEHRAcIuT1xeGNUrdjYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527835; c=relaxed/simple;
	bh=yXFV9kxjDtuf8D75RcUN9npkhbqNaK2uQv+W214LqnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gA2UAea49cDTksvTX3WtgNN8I50nMHwolkUSpRNW9/LzJ0GksVNBW/NAPuXbSBmhh1PTbWtBg6Q5EpebQne7O19XpJgeo5F5VNvPeYQA356AzO1xwzoFEBE2PGcj/SiQffaaPjmTbJiBHx/9pc80YCqvj/+m4kIbxTMCK4Nt7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WztxB3xNNzpVGt;
	Thu,  5 Sep 2024 17:15:10 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D0691800CF;
	Thu,  5 Sep 2024 17:17:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 5 Sep
 2024 17:17:04 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>
CC: <linux-hardening@vger.kernel.org>, <lihongbo22@huawei.com>,
	<chris.zjh@huawei.com>
Subject: [PATCH -next v2 1/2] lib/string_choices: Introduce several opposite string choice helpers
Date: Thu, 5 Sep 2024 17:25:39 +0800
Message-ID: <20240905092540.2962122-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905092540.2962122-1-lihongbo22@huawei.com>
References: <20240905092540.2962122-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Similar to the exists helper: str_enable_disable/
str_enabled_disabled/str_on_off/str_yes_no helpers, we can
add the opposite helpers. That's str_disable_enable,
str_disabled_enabled, str_off_on and str_no_yes.

There are more than 10 cases currently (expect
str_disable_enable now has 3 use cases) exist in the code
can be replaced with these helper.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 include/linux/string_choices.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index f3670dbd1169..c2134eeda1fd 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -8,11 +8,13 @@ static inline const char *str_enable_disable(bool v)
 {
 	return v ? "enable" : "disable";
 }
+#define str_disable_enable(v)		str_enable_disable(!(v))
 
 static inline const char *str_enabled_disabled(bool v)
 {
 	return v ? "enabled" : "disabled";
 }
+#define str_disabled_enabled(v)		str_enabled_disabled(!(v))
 
 static inline const char *str_hi_lo(bool v)
 {
@@ -36,11 +38,13 @@ static inline const char *str_on_off(bool v)
 {
 	return v ? "on" : "off";
 }
+#define str_off_on(v)		str_on_off(!(v))
 
 static inline const char *str_yes_no(bool v)
 {
 	return v ? "yes" : "no";
 }
+#define str_no_yes(v)		str_yes_no(!(v))
 
 static inline const char *str_true_false(bool v)
 {
-- 
2.34.1

