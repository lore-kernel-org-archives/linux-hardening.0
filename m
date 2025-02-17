Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B51217737
	for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787473; cv=none; b=SE7rnrXHtlrKuMS53EapNb+QhKn7lRGVDjXOM4hFJitzI/bh/OrazOC6oje9YzAaCpLSlVxKRd8nkppCvY347dMsmjk9XupQ6fnndRH34LG3LSntuj3htJKFAT4WrSmvMsn6D5Ku2vU9J+AYWFUWeaAUPLxMHSy31TcMdXvCxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787473; c=relaxed/simple;
	bh=eFWO0XMyikPo+vVZcTF2JAqlcgoQWkxVrK0g2v9jJKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gH8rQd6VgANnSfhq/i+hkrHoWVQVz49skG/RABAaySovGkiBkNtFkcGe6151l8Pjyy+OiRs27pkTq9zvC8yk2vIkhqoEKIiTujC2HwIfY6Aj5d139EHi9YgzBbSlscYGoyxk6NM80E2cj0UO/uen3yFOuaYWHkqhlXpklPEhiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPwTTUmy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPwTTUmy"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb8e405640so160925066b.0
        for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 02:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787470; x=1740392270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXzcU5MFpNvV+1Iapr36hDkhqv8Rk3kBwf8g/lXGurs=;
        b=zPwTTUmyqxl8VMtjBdDo5Z0YJvwXoHjP2sQO66sKway7vNYc9urrz8FNQAlzj/uzx7
         Pbp9TmHC85rN1Fk99yTi73gziiFWdU3MykNYvfvIsvRJs286tb7fCHJgPPO7JTJ1/s1B
         9L5Zfr04QeGGLYb+p2/NmgrbuXJqEocRQ8NGtCasqnEYnhVg/Y8EdfR821SzYnqz5SgA
         7zdTgWnWBsUKj4sQOFApoImt828PARcfnVGbem6mpTi/msqZTRcei0sDndEN8NhOgoXk
         WOhDW2TF0UjhciJkoBZy5eZq3PGzZZ5Lja+R/AK83o1k6w1+WSR1z5iT+SfZQqCQhCc4
         1XZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787470; x=1740392270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXzcU5MFpNvV+1Iapr36hDkhqv8Rk3kBwf8g/lXGurs=;
        b=JPWdV4N2K6WtqECr56qFNGaTFsHaQZgOQ5m0sNm+lEf6rCSow6pybN3Ugu/td9vRUc
         eCAP9QALq6En2CzIldIjFb8318TxG8BgPwg+m8LaQIZLbFaDkluroxpbUgFDf97b6NRR
         Sirw7IW8Z5v1h7OKK97A3BxT7iA5mr1g/MCZp+Io1nmowS/Dj2Xt7dUPG2cbRdB0DDAh
         MdGlLy1w+4y2ylxHBvnF44Y8UNXJHv8ePUgHAzX5Pxy0xz+eS+Z91XgoCeodMEv5DvLE
         3wwKQW6Cm3R8ccYC0HaVXTsFBfj4Xg/zghgK8c8i4YTMr+ToW4LIL3kRqe9rqOOp4Rlj
         Ay0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxG5chbYWq+Ozl6TKaqArnqIvx6JqnKGvpOSgNNQPbgEssbUcZXKJyCeMfrLfOtcsEVWtszytteZcX84Ik6ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YweSCzQt9Gvjz/oEfDX2UH9G80eFC+pzF+BBFIgJ5gLpiErveBZ
	AHM/eOHeXNARdLWQDhEHuyPm1w8BjwXQmmzUoig1e0OTIxAlsn+6qWjGCnQLQhc=
X-Gm-Gg: ASbGncubLtignT9Azz3RB88XbGICGyhAzptnI7lo+H2ncxUzrKqOhOcp1j6kHMVjYn/
	RAs6Tqr3qbis3rybrlM03qB528sPpgaeEdUn447fZRPVSCvVCSDnxXZ15vtf6Hh2olxIFg+Llwq
	d4zO3qF2IsnBpxAJVJWpMgwt4Jsj1elqBAMFae7r1O25Ctqc7c02xBIYurAd0jYmRsD+PGnbZ9l
	eHPcmxw27Y7mw5YpaMj9Nn6kULhcQqaRNNzs88Hb3q14W3OgEe2HL3k7L/+K0niolNBx7sPUFgI
	0/88vF+Q9bklXWWSITONHLdm
X-Google-Smtp-Source: AGHT+IFlpcMLdWWAy879FRRX8kAbYx+cTtUPfK71e6uWIwxDjhZr04LaUoJwILHRa7T4Dh47h6Jv7g==
X-Received: by 2002:a17:907:d27:b0:aba:5f40:7f2e with SMTP id a640c23a62f3a-abb70d95048mr848206466b.45.1739787470024;
        Mon, 17 Feb 2025 02:17:50 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:49 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 03/10] pstore/zone: introduce directly mapped zones
Date: Mon, 17 Feb 2025 12:16:59 +0200
Message-ID: <20250217101706.2104498-4-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Directly mapped zones have a different semantic from usual pstore zones.
Such zones use a pointer to data in their buffer struct, instead of
keeping the buffer locally.
The data pointer and size is then passed to the backend for further use.
Having a different semantics, backends supporting only these do not offer
read/write ops, and only new register_dmr and unregister_dmr ops.
Ofcourse, a backend could support both classic zones and directly mapped.
Directly mapped zones have the advantage of not being passed through
in the event of a crashed, but rather at registration time.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 fs/pstore/platform.c        |  1 +
 fs/pstore/smem.c            |  6 ++---
 fs/pstore/zone.c            | 45 ++++++++++++++++++++++++++++---------
 include/linux/pstore.h      |  4 ++++
 include/linux/pstore_zone.h |  3 +++
 5 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index f56b066ab80c..e20e60b88727 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -51,6 +51,7 @@ static const char * const pstore_type_names[] = {
 	"powerpc-common",
 	"pmsg",
 	"powerpc-opal",
+	"directly-mapped",
 };
 
 static int pstore_new_entry;
diff --git a/fs/pstore/smem.c b/fs/pstore/smem.c
index 9eedd7df5446..684ecc20cae5 100644
--- a/fs/pstore/smem.c
+++ b/fs/pstore/smem.c
@@ -36,15 +36,15 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 		pr_err("NULL device info\n");
 		return -EINVAL;
 	}
-	if (!dev->zone.total_size) {
+	if (!dev->zone.total_size && !dev->zone.dmapped_cnt) {
 		pr_err("zero sized device\n");
 		return -EINVAL;
 	}
-	if (!dev->zone.read) {
+	if (!dev->zone.read && !dev->zone.dmapped_cnt) {
 		pr_err("no read handler for device\n");
 		return -EINVAL;
 	}
-	if (!dev->zone.write) {
+	if (!dev->zone.write && !dev->zone.dmapped_cnt) {
 		pr_err("no write handler for device\n");
 		return -EINVAL;
 	}
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 5fa2fa2e7aa7..affa4370208c 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -113,6 +113,7 @@ struct psz_context {
 	struct pstore_zone *ppsz;
 	struct pstore_zone *cpsz;
 	struct pstore_zone **fpszs;
+	struct pstore_zone **dmszs;
 	unsigned int kmsg_max_cnt;
 	unsigned int kmsg_read_cnt;
 	unsigned int kmsg_write_cnt;
@@ -120,6 +121,7 @@ struct psz_context {
 	unsigned int console_read_cnt;
 	unsigned int ftrace_max_cnt;
 	unsigned int ftrace_read_cnt;
+	unsigned int dmapped_max_cnt;
 	/*
 	 * These counters should be calculated during recovery.
 	 * It records the oops/panic times after crashes rather than boots.
@@ -1148,6 +1150,8 @@ static void psz_free_all_zones(struct psz_context *cxt)
 		psz_free_zone(&cxt->cpsz);
 	if (cxt->fpszs)
 		psz_free_zones(&cxt->fpszs, &cxt->ftrace_max_cnt);
+	if (cxt->dmszs)
+		psz_free_zones(&cxt->dmszs, &cxt->dmapped_max_cnt);
 }
 
 static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
@@ -1160,9 +1164,9 @@ static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
 	if (!size)
 		return NULL;
 
-	if (*off + size > info->total_size) {
-		pr_err("no room for %s (0x%zx@0x%llx over 0x%lx)\n",
-			name, size, *off, info->total_size);
+	if (*off + size > info->total_size && type != PSTORE_TYPE_DMAPPED) {
+		pr_err("no room for %s type %d (0x%zx@0x%llx over 0x%lx)\n",
+			name, type, size, *off, info->total_size);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1170,7 +1174,8 @@ static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
 	if (!zone)
 		return ERR_PTR(-ENOMEM);
 
-	zone->buffer = kmalloc(size, GFP_KERNEL);
+	zone->buffer = kmalloc(type == PSTORE_TYPE_DMAPPED ?
+			       sizeof(struct psz_buffer) : size, GFP_KERNEL);
 	if (!zone->buffer) {
 		kfree(zone);
 		return ERR_PTR(-ENOMEM);
@@ -1179,7 +1184,10 @@ static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
 	zone->off = *off;
 	zone->name = name;
 	zone->type = type;
-	zone->buffer_size = size - sizeof(struct psz_buffer);
+	if (zone->type == PSTORE_TYPE_DMAPPED)
+		zone->buffer_size = 0;
+	else
+		zone->buffer_size = size - sizeof(struct psz_buffer);
 	zone->buffer->sig = type ^ PSZ_SIG;
 	zone->oldbuf = NULL;
 	atomic_set(&zone->dirty, 0);
@@ -1188,8 +1196,9 @@ static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
 
 	*off += size;
 
-	pr_debug("pszone %s: off 0x%llx, %zu header, %zu data\n", zone->name,
-			zone->off, sizeof(*zone->buffer), zone->buffer_size);
+	pr_debug("pszone %s: off 0x%llx, %zu header, %zu data %s\n", zone->name,
+			zone->off, sizeof(*zone->buffer), zone->buffer_size,
+			zone->type == PSTORE_TYPE_DMAPPED ? " dmapped " : "");
 	return zone;
 }
 
@@ -1206,7 +1215,7 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
 	if (!total_size || !record_size)
 		return NULL;
 
-	if (*off + total_size > info->total_size) {
+	if (*off + total_size > info->total_size && type != PSTORE_TYPE_DMAPPED) {
 		pr_err("no room for zones %s (0x%zx@0x%llx over 0x%lx)\n",
 			name, total_size, *off, info->total_size);
 		return ERR_PTR(-ENOMEM);
@@ -1245,6 +1254,15 @@ static int psz_alloc_zones(struct psz_context *cxt)
 	int err;
 	size_t off_size = 0;
 
+	cxt->dmszs = psz_init_zones(PSTORE_TYPE_DMAPPED, &off,
+			info->dmapped_cnt,
+			1, &cxt->dmapped_max_cnt);
+	if (IS_ERR(cxt->dmszs)) {
+		err = PTR_ERR(cxt->dmszs);
+		cxt->dmszs = NULL;
+		goto free_out;
+	}
+
 	off_size += info->pmsg_size;
 	cxt->ppsz = psz_init_zone(PSTORE_TYPE_PMSG, &off, info->pmsg_size);
 	if (IS_ERR(cxt->ppsz)) {
@@ -1302,7 +1320,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	int err = -EINVAL;
 	struct psz_context *cxt = &pstore_zone_cxt;
 
-	if (info->total_size < 4096) {
+	if (info->total_size < 4096 && !info->dmapped_cnt) {
 		pr_warn("total_size must be >= 4096\n");
 		return -EINVAL;
 	}
@@ -1312,7 +1330,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	}
 
 	if (!info->kmsg_size && !info->pmsg_size && !info->console_size &&
-	    !info->ftrace_size) {
+	    !info->ftrace_size && !info->dmapped_cnt) {
 		pr_warn("at least one record size must be non-zero\n");
 		return -EINVAL;
 	}
@@ -1345,7 +1363,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	 * if no @read, pstore may mount failed.
 	 * if no @write, pstore do not support to remove record file.
 	 */
-	if (!info->read || !info->write) {
+	if (!info->dmapped_cnt && (!info->read || !info->write)) {
 		pr_err("no valid general read/write interface\n");
 		return -EINVAL;
 	}
@@ -1365,6 +1383,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
 	pr_debug("\tconsole size : %ld Bytes\n", info->console_size);
 	pr_debug("\tftrace size : %ld Bytes\n", info->ftrace_size);
+	pr_debug("\tdmapped areas : %ld\n", info->dmapped_cnt);
 
 	err = psz_alloc_zones(cxt);
 	if (err) {
@@ -1406,6 +1425,10 @@ int register_pstore_zone(struct pstore_zone_info *info)
 		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
 		pr_cont(" ftrace");
 	}
+	if (info->dmapped_cnt) {
+		cxt->pstore.flags |= PSTORE_FLAGS_DMAPPED;
+		pr_cont(" dmapped");
+	}
 	pr_cont("\n");
 
 	err = pstore_register(&cxt->pstore);
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index fed601053c51..8360d94c96b6 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -39,6 +39,7 @@ enum pstore_type_id {
 	PSTORE_TYPE_PMSG	= 7,
 	PSTORE_TYPE_PPC_OPAL	= 8,
 
+	PSTORE_TYPE_DMAPPED	= 9,
 	/* End of the list */
 	PSTORE_TYPE_MAX
 };
@@ -199,6 +200,8 @@ struct pstore_info {
 	int		(*write_user)(struct pstore_record *record,
 				      const char __user *buf);
 	int		(*erase)(struct pstore_record *record);
+	int		(*register_dmr)(struct pstore_record *record);
+	int		(*unregister_dmr)(struct pstore_record *record);
 };
 
 /* Supported frontends */
@@ -206,6 +209,7 @@ struct pstore_info {
 #define PSTORE_FLAGS_CONSOLE	BIT(1)
 #define PSTORE_FLAGS_FTRACE	BIT(2)
 #define PSTORE_FLAGS_PMSG	BIT(3)
+#define PSTORE_FLAGS_DMAPPED	BIT(4)
 
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index 284364234162..a74d0cc75577 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -48,10 +48,13 @@ struct pstore_zone_info {
 	unsigned long pmsg_size;
 	unsigned long console_size;
 	unsigned long ftrace_size;
+	unsigned long dmapped_cnt;
 	pstore_zone_read_op read;
 	pstore_zone_write_op write;
 	pstore_zone_erase_op erase;
 	pstore_zone_write_op panic_write;
+	int (*register_dmr)(char *, int, void *, size_t);
+	int (*unregister_dmr)(void *, size_t);
 };
 
 /**
-- 
2.43.0

