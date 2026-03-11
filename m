Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755336C9F5
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271619; cv=none; b=dB/wnrI5b5GYEXpcltTlk9gFAJTafn7Iw0zELcmWQJ9NDVlrZxWpIcxQ1dBCWJ7yGkzrD/b6dowx9wmJo43uuyTapOg3JCPNDhDlemB/c2BJuQU/5T9awPG5dqhiPHxqvhGWZxNNKGZ+yuIaZ5AES8IutwIlwpEClsKt845n7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271619; c=relaxed/simple;
	bh=Aeamlkyrp/Tri78LJI5YT+eY+rTSWMhlN4ljcbL+1vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YR9ntAPKhN1om0WSoUGi7V0C8W0GQVSCjuRjN95IL3xN6DosLCQlNDOTf2RwTGNcqXAcwQxWHmlnvlbtuCYEX2/oG6IscRCXOrDoT2du05PTqkvDRIKFB/oDb6tHRgD3ir/cMiliVOB+4QO5mXeLWh1JkuCaHv2M6XVcNtft98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noKHxHOQ; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noKHxHOQ"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ae222d978so579833d50.1
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 16:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773271616; x=1773876416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xE9cexzHArZthFPt7zjFOtjoKCh1E9B4tVZ/2MEZ4pY=;
        b=noKHxHOQfHsxFAO0lu9heJVZjvhB4c2TKJpddDzPT+wEFT+GlTuKYyy1EhuE3ZyVOc
         9D9b02eODeT/X+vdwprTFzTGisSyX13suaro5t4EKsuviokaG0JnX3OsK7b692LYBKfG
         qezrrAijd6iPTtxPquqiRyiuPCxkeruK6TTzws1ZrSx/PhAdtBI5YyjPWKnqNJOlVsw/
         dnCEdXFxXZo5ePYMLh8ad2xSzduwmam4Vv3mbT2TGeb+ZxWm1IL7JDQlstpeoWfrlU9j
         0Six0iIeIfgH+xhFN0lIUh6JHYn4Ua3xkSNGTl5iDU6SpbMjeWYmRkZ5c4wEzDycbgrV
         Gu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271616; x=1773876416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE9cexzHArZthFPt7zjFOtjoKCh1E9B4tVZ/2MEZ4pY=;
        b=plVTUyHoHSS/MdkF7UPJgnq9TYgw0EBOcP+EuPKpU6QZ3uXswZfgjnYyy12zHm+bn7
         1LzfNXa/fGPw8G+oj8H72CJFFJ8kp32MMNzIXCcOdKvVJO3AG3KSdQR3y5PfJdlm+UsA
         WlhMWsGtt4YFNOKm/Y35nUXkPtqXQxxT7dkUMvOLjXZviTqz7H/NWDY67VK55ZHXzgyD
         Jk9nJIQH4lLhB+fvuAnxXzs7yAj1zkyry1CfX5RH2ooEAMB1jSar6RqdDbcorIgOVls/
         4RtAv0sE0wZmfvlRMAYRCquq3NnONL5jqv0hxLPLAWxjYwCjFlVmJiIZ7UxhNTtbk6eG
         sChQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOdEAgkS52yz//+NNm4kgII+Z00jqDxACfc+CyZFQCm/6nprC+K7bVWSNMEPlAeo1kn9rfffwvK4BXm+Y6c8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7g12KeBZ8IinzdS7vwFEYTBOomEjt2Ef6VuxdP5a7CgHy4mA1
	wsoT3jIxOqf+9dJmgzQ7r7Jyp87+UfEalH93pLzfUPIj2LwvK8b1sbLW
X-Gm-Gg: ATEYQzxXpExT5TsVP0SJhMehQOLTxSdlmzVqOvSqZ93vRUDw+UpBOtx5WqFQlRZsock
	519yucQPQfTFckWDPKsPA8YqFYqMQFkIBz0x5c8wu7LcT79MHYjjH3l8p216gpt1JrUuZH/xCGW
	nDHRKpue1eG5h9bK8mkDGdaiZte6oaW2SJmhq42mofJVGBResVupQnSktPEPHam9su39/PTz+Ge
	TO2iKvVgKuObEwK4oGXVSPl8LDqopmq+NKLwDRAmPU1UfagaYJGM/hSdJAXQH4NI9B3Xm7UtRjG
	Vj9+MOB3P8E2oMPuAAvfyariahlgjr5oRPzmertiti8iu0nrf3Y5EUsVki3+ZUXkEf6vEb9Xobg
	8ufYNW74/bL1IPwoXxru+S0OEZj5+gyTO3nx3AMyD8cvHVg9K2n8SLuBYeK/681RZUrsqcGFFZk
	+7Ko8EweK57j15z0t2Vk6i3FtNOi7hNG6808Y6ckSKApVNs4qrBgQB9A==
X-Received: by 2002:a05:690c:6:b0:798:2723:ab40 with SMTP id 00721157ae682-79917ecc38fmr42758297b3.22.1773271616175;
        Wed, 11 Mar 2026 16:26:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917e2019fsm22517987b3.19.2026.03.11.16.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:26:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] EDAC, i7core: use kzalloc_flex
Date: Wed, 11 Mar 2026 16:26:38 -0700
Message-ID: <20260311232638.18585-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations by using a flexible array member in this struct.

Add __counted_by to get extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/edac/i7core_edac.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 0f783173d0ec..b87c4c6471ea 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -240,9 +240,9 @@ struct pci_id_table {
 struct i7core_dev {
 	struct list_head	list;
 	u8			socket;
-	struct pci_dev		**pdev;
-	int			n_devs;
 	struct mem_ctl_info	*mci;
+	int			n_devs;
+	struct pci_dev		*pdev[] __counted_by(n_devs);
 };
 
 struct i7core_pvt {
@@ -455,18 +455,12 @@ static struct i7core_dev *alloc_i7core_dev(u8 socket,
 {
 	struct i7core_dev *i7core_dev;
 
-	i7core_dev = kzalloc_obj(*i7core_dev);
+	i7core_dev = kzalloc_flex(*i7core_dev, pdev, table->n_devs);
 	if (!i7core_dev)
 		return NULL;
 
-	i7core_dev->pdev = kzalloc_objs(*i7core_dev->pdev, table->n_devs);
-	if (!i7core_dev->pdev) {
-		kfree(i7core_dev);
-		return NULL;
-	}
-
-	i7core_dev->socket = socket;
 	i7core_dev->n_devs = table->n_devs;
+	i7core_dev->socket = socket;
 	list_add_tail(&i7core_dev->list, &i7core_edac_list);
 
 	return i7core_dev;
@@ -475,7 +469,6 @@ static struct i7core_dev *alloc_i7core_dev(u8 socket,
 static void free_i7core_dev(struct i7core_dev *i7core_dev)
 {
 	list_del(&i7core_dev->list);
-	kfree(i7core_dev->pdev);
 	kfree(i7core_dev);
 }
 
-- 
2.53.0

