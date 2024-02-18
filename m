Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0AE610C
	for <linux-hardening@vger.kernel.org>; Sun, 18 Feb 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708230344; cv=none; b=cdNVGsyNpRvk4NEa2HS5IzLrrsU6EhQl/BZ6iJIJx6IRV4yuvOEA6jHN/eeXd+Guqktn14M1gNmHrdHtl63GYgAttYAt2Uk/5d8yj1nsxh15EDPpQ+Q7ZcnHV+FOWlySFgtAi4nYPzqIZxjf5CiqfEslhxrF5REhDeugPvBQimk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708230344; c=relaxed/simple;
	bh=8X2LbBluiP62PhY4yTx2Vm7OR5mhIBYACk5drh7CJDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SvLIVyZlVduojm9UKNH6IRup899JRl6sF0y8seajVhV65roxN/ZhwTU9UnV+2FjUCMipVFpXccbnR86ryN1EzXaJQqtZcaJqqz3037NffC7AcZ/PcmRGRXGQrFl8nNdu5dwMTIyI/nNVOsJd+e/MxLOPTqz5hZU9H+IqtGWE4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hAjeusk3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hAjeusk3"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b519e438so3128303a12.1
        for <linux-hardening@vger.kernel.org>; Sat, 17 Feb 2024 20:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708230342; x=1708835142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPPOVToP9KvYFFYAhd+euhiEp/R/1IO3VQIxg89zLZk=;
        b=hAjeusk3a+b3Tdepb9qBRtSsPMYj6LSe1dil95hBwTw4/eFeSzYzwIz5A11Zj45vMO
         br/EkBaWN1hyMcgEnDyagfI4Ye7UDtLdUnkZWife3JCcf6xODHgL6woJarTXY1rYcqFa
         h6LHzIRQa+NRk9a42IvT2WvKrMMbz3+6iKUe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708230342; x=1708835142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPPOVToP9KvYFFYAhd+euhiEp/R/1IO3VQIxg89zLZk=;
        b=D0RuQwxiUYbHo0L0IJfLK+zdm7t49CSe/VBmisk6aO6THiNBha3+3f5dhvC3hYPveQ
         gGqzWyIUVfeB3u8VhX+41ofDwUxf3u1yIWl9g3nOJ+sbdI0I4ZC4E+raSQ67sMRAor2r
         bNzq8c0KvLMGNL+aLw0tpDdJfmjWkLg/1I+X1NibZMzqZoNmqlWf6sOYigw/hiuXRqpe
         s5SipKN+8feX4BicoYTebmkIkMyFOEWlZanjt2x/9Jo9xb1p91qMZ3CUQegZdqfRJBsV
         XDYSnrQ3uBVgVoeAdYV7wIz8FzmKnWpdMW0CGLIVgnCW2BdyF9Z8JSwOlzIdmsbnvryT
         r1/w==
X-Forwarded-Encrypted: i=1; AJvYcCVGhuh8U77Leip+jdfjlLvrZwcoyomAYE+51GQRn6+AbwXPrO+1MIeX1Cqv6/xgTk6W3GaB2Xyc3L/Gu3zTgNBoSwyn9wm/CQs9J0Jo6smH
X-Gm-Message-State: AOJu0YzYZdywRL6G81778wCMX29m+3Vi5Ky6hqXMC3KIUgbOXdoI+pPh
	4xJDYWCepWbrvdMdzQSLrKX8/k/TEZp0dSn5eyk8oRErS+aP21XNeqjjNWq5jw==
X-Google-Smtp-Source: AGHT+IFjk09QrySxOgBtDCo76+mGw+pZNd0U5JFGwf/tqqImzzxQdPNFpc9iNKIfio5NAiR63Hw3VQ==
X-Received: by 2002:a17:902:b20b:b0:1db:4b23:f97b with SMTP id t11-20020a170902b20b00b001db4b23f97bmr7487589plr.59.1708230342654;
        Sat, 17 Feb 2024 20:25:42 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b001db54324488sm2142726plb.38.2024.02.17.20.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 20:25:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Kees Cook <keescook@chromium.org>,
	Navid Emamdoost <navid.emamdoost@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4] nbd: null check for nla_nest_start
Date: Sat, 17 Feb 2024 20:25:38 -0800
Message-Id: <20240218042534.it.206-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0R8zCu0X/ARVuSqlyl7fu4di67hYDgO+9WqGqz+HaEc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0YbBPe25EqmI5l5nzuL7+soJkeVhsbtCpCkDH
 ubGmi/BvUiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdGGwQAKCRCJcvTf3G3A
 Jm4SD/4k25Oc6EkBmLy4hVwdpNNdRv+uyAuAXQKD7aOBOpyDpt8qh8Wjxpe+PkBlP8wDVT7g+hi
 SDxOzbm7NvrlnYL6aF9fyDUz1W2tmTVvVnTJuDOIxdMRT4Z9Eer9IhO+LEXmuY8WevRZrbFgnKl
 /n+ZC3HYgck0RexH2TJBbMulSVwwh/rgxqbY4NPz19YLMRs1W4k+artJg6buZ9B+VEFT1WYoNU3
 r33Kr5nru90Yd1QyCEAV28QqD37LynEdBgkUj58fmnzWx5hYluvUR+cSDvtt+ov7Ie5/bcBOoXG
 lArRTlM6G3GMBDcPWXs8AZ3jJPc3YnyK/N9yvyL0VKqfJQcErqJy2RhCS0PbLZkKjQW1ofg3cm8
 3QKhCRRkRDKTCx6FOL7fNT+P5ealU0YBNhatm4gAUl/+9Bn7vTXqWt3NQ8XyPm8TYgf0R3assGN
 NRnf4P/0HkcKTOIx9w7FC7BA2jMXJJAxXxVUPlFNuznghWXsPQQccfjqxjibsjY7bJBa05ljLo8
 7rLaFHTHiVQe8oVL5RR8joZAmlHLGgQjUxLAVm+VoJrP4QMKUOW6wCAGzHWJnFEPupswbmlV/eZ
 rwitO9926hht8LZtRlvZNm2vco0tFIvBmFgkJ0nO2ZuhY3cWZ9sOA1zf70bgn5re+XXe2oYEpFe
 Qx6xzOa L6H7WvAw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Navid Emamdoost <navid.emamdoost@gmail.com>

nla_nest_start() may fail and return NULL. Insert a check and set errno
based on other call sites within the same source code.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Fixes: 47d902b90a32 ("nbd: add a status netlink command")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3- https://lore.kernel.org/lkml/20190911164013.27364-1-navid.emamdoost@gmail.com/
Resending on behalf of the author. This seems to have gotten lost and
has been getting tracked as CVE-2019-16089 ever since. For example:
https://ubuntu.com/security/CVE-2019-16089
---
 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 33a8f37bb6a1..b7c332528ed7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2433,6 +2433,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		nlmsg_free(reply);
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.34.1

