Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E069B328611
	for <linux-hardening@vger.kernel.org>; Wed, 18 Mar 2026 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859978; cv=none; b=QKiHbBnEGvDq4TKVW3+/Apkgtb1pMeth46Z+hxP1DVeZ78bOi2TG1A9hlo8yhIFcz5IxzNqa31RS/2HkxGjjHF/xVDhT9LbWhqV1x/eGW0gFyNSBHfeNZHklp8gTKpZc4PTSD+zzDwXkmaJ80M77VO+HY+OeLNkkvjgipVC1/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859978; c=relaxed/simple;
	bh=UCngcFeX5vh68hnFGhGjT/S5NFDy3cR2mGBh4g9ppOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPKKxnglr5IiBFqYcIYu8GpBLbr8kn37aSW1zdB2cTIpUw4hbL//gOeUJp+OToJu3VCcVRn+pqL/Pdu571kAnF2BXowtEHCJdLi60ZPOGHYdplWS0M8QuWsijPAdkwKlMDLi6wqCwhtlecZPq6Zr+8ElEFZ1HlPzaGYxD5kAUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbSuBvpc; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbSuBvpc"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a2ee65171so2626977b3.2
        for <linux-hardening@vger.kernel.org>; Wed, 18 Mar 2026 11:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773859976; x=1774464776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EaAhVFjEj7aLMwcXOusWyl6mHSsBkmDOc0v8egWd334=;
        b=FbSuBvpcS1cHE8n6UItqpDFLCI0ZRp1S7V9Anf/zkZ867hMYVOAQPIfKmcGzgNNlIZ
         MxUBytZj4SnvNsCuaPPQqzG5BnFt6/v2urCOaN7RXN4+J1q5jw4geTN2NjffA1f+BsG1
         eJSebyNfWsoyU3gSQbfTuDmrGvohUx87pb+X3pBVxaKKS027nUhxTL433vwzC2uyFZgN
         klhLiZKEKqrcV6G5g+FO1+g/GmqjK63fcG0EK/pSh3rSBLNaXa3rSZYAdQ4Js8PBRO2j
         BYQ1Qojhesdc2GCL476C6phtigLW7WjPGoWzt9ycYql11hv3n67nd+MHQaWNGosObyx3
         s3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773859976; x=1774464776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaAhVFjEj7aLMwcXOusWyl6mHSsBkmDOc0v8egWd334=;
        b=Qwh4ccnSVgvIAhFBpHrhVp3BBMQwu5gpQyX/VNkRYcKjRdmR8a5DxQRPA0ACl/l16B
         hDwk6TogN5mitlNBGvZWqY/P80AiPr5fkJUuz8ljSZNtbJlKBn1eXaVJrY76lOwfFBOb
         nAjljryQClr9Nt/tjRPs+puGUIeZ+fcBpcRA+HtlmQYhBfgjbyF+suxrpVrjIAU/C7GH
         58B2IBjde0Sxm3JPNFWE/mOKgs5u982K5LA/G3cwNl2//PKLemcZY+ExhA9tS8O0rGVb
         IsGEOBz+gzJICXZJ8MYfRklyYSpT1yDs9MuZo7hBn+h4K1kyE4dDlIcfRW8u+oMjb/ou
         jw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5yslDndnpuAZYUcsozNqrLZC/Uw4OcqOcfHddYnkPuPKNLYCZZRVKI2xwsYXFUZ+HO7BsyPyudQBVfKSiYeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8BIoEe2buWNsZw4TluJrG06TtDnQATNFvtVMX6Ewb8hafEru
	AWtB0vlRxBF3vP28X5/1xsatEwfyH9K9vLyThwHeovlQpZ/1PnOCUlhnEwmMPw==
X-Gm-Gg: ATEYQzz5AJY4PE+gpKGjhrUufwMWAS3ESwsDikrO6Fu974BujWnydjCe7k77Tp0V0ve
	7BLMA1dY76P9SBK9P5v+DZ+BzsNcUHBCjmyV35cE7ZjhGVadDoPkoNL3IT+ezcTj7hQLTskqxGC
	QfcaW2oGkn7OUjWHLdwN24wYLVidFmcBR1osAZ5sEaahnOC/bQ6RIB2ZRro1j9BNH+OU/WHXw7o
	Lh867RmpHbd2YBeFCqV6fHDSXwUAp5OGR3tEKH82sXnKgAG2H4VB3oVzsLpKlTRsiJuhgcCVz76
	Isv4WPV9t4ABQL0wh+lfzK37cKQtU0Bvas9rzgZ7MGHs4Hx1T2Di8wNCeZAzml4LksY9JncQqUZ
	90iR/afsGGwM9R0GuofQ58C7O3JnLXCqqxD+WaUZ4AzhCTW0cWdEm7s6UbezlwH4MiDUI6ss8zm
	T9NFRvafmAxpAmjosKuV/3rZcA6TGf47Nub6IhYx5HTpMDh2VcdmDAsHE=
X-Received: by 2002:a05:690c:c4e3:b0:79a:7cf4:1a60 with SMTP id 00721157ae682-79a7cf420d2mr20355937b3.48.1773859975837;
        Wed, 18 Mar 2026 11:52:55 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a71593c08sm21689017b3.24.2026.03.18.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 11:52:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3] thunderbolt: use kzalloc_flex
Date: Wed, 18 Mar 2026 11:52:37 -0700
Message-ID: <20260318185237.4742-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation by using a flexible arraay member.

Added __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: fix kdoc
 v2: remove extra kfree to fix kernel test bot.
 drivers/thunderbolt/path.c | 28 +++++++---------------------
 drivers/thunderbolt/tb.h   |  5 +++--
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 22fb4a1e1acd..8713ea0f47c1 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -150,22 +150,17 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
 		num_hops++;
 	}

-	path = kzalloc_obj(*path);
+	path = kzalloc_flex(*path, hops, num_hops);
 	if (!path)
 		return NULL;

+	path->path_length = num_hops;
+
 	path->name = name;
 	path->tb = src->sw->tb;
-	path->path_length = num_hops;
 	path->activated = true;
 	path->alloc_hopid = alloc_hopid;

-	path->hops = kzalloc_objs(*path->hops, num_hops);
-	if (!path->hops) {
-		kfree(path);
-		return NULL;
-	}
-
 	tb_dbg(path->tb, "discovering %s path starting from %llx:%u\n",
 	       path->name, tb_route(src->sw), src->port);

@@ -245,10 +240,6 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 	size_t num_hops;
 	int i, ret;

-	path = kzalloc_obj(*path);
-	if (!path)
-		return NULL;
-
 	first_port = last_port = NULL;
 	i = 0;
 	tb_for_each_port_on_path(src, dst, in_port) {
@@ -259,20 +250,17 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 	}

 	/* Check that src and dst are reachable */
-	if (first_port != src || last_port != dst) {
-		kfree(path);
+	if (first_port != src || last_port != dst)
 		return NULL;
-	}

 	/* Each hop takes two ports */
 	num_hops = i / 2;

-	path->hops = kzalloc_objs(*path->hops, num_hops);
-	if (!path->hops) {
-		kfree(path);
+	path = kzalloc_flex(*path, hops, num_hops);
+	if (!path)
 		return NULL;
-	}

+	path->path_length = num_hops;
 	path->alloc_hopid = true;

 	in_hopid = src_hopid;
@@ -339,7 +327,6 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 	}

 	path->tb = tb;
-	path->path_length = num_hops;
 	path->name = name;

 	return path;
@@ -372,7 +359,6 @@ void tb_path_free(struct tb_path *path)
 		}
 	}

-	kfree(path->hops);
 	kfree(path);
 }

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e96474f17067..217c3114bec8 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -419,9 +419,9 @@ enum tb_path_port {
  * @activated: Is the path active
  * @clear_fc: Clear all flow control from the path config space entries
  *	      when deactivating this path
- * @hops: Path hops
  * @path_length: How many hops the path uses
  * @alloc_hopid: Does this path consume port HopID
+ * @hops: Path hops
  *
  * A path consists of a number of hops (see &struct tb_path_hop). To
  * establish a PCIe tunnel two paths have to be created between the two
@@ -440,9 +440,10 @@ struct tb_path {
 	bool drop_packages;
 	bool activated;
 	bool clear_fc;
-	struct tb_path_hop *hops;
 	int path_length;
 	bool alloc_hopid;
+
+	struct tb_path_hop hops[] __counted_by(path_length);
 };

 /* HopIDs 0-7 are reserved by the Thunderbolt protocol */
--
2.53.0

