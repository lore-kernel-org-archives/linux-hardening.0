Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49B08635D
	for <linux-hardening@vger.kernel.org>; Fri,  2 May 2025 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148393; cv=none; b=nZDn3Hx1b6RgkHzV7n1ls1KEWlZiIibuEZPjvyOGl5Xpwe/9ht1Kq/VH6Ehut8FzrGiVGPS9+uu7O0sTATe9r/qVyoMMXdRULbDUBv83NbNsuwu3GeZykEosER7oyEa+qhXbooN30lTEgCJ2MuT2bwbJT5MNpF23CTiTeTku3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148393; c=relaxed/simple;
	bh=xGq6E1Xm4xowTjcw7xDmWLNzTZI63dDxQ9UmgG7Pajo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IkcdKzaiiCpEiu6PShUaABHEj/Y4xd37NzZyVZJF/gzNav1kTYTY7HyvSygfWb3/kQRMf3mDUYbHfNmphwHPresU1IgBybZSt5XNaBlfQjvxvGaLF3nMZVU0XO+2MaxdgPOf28UMGnp7W/GjZeUGKTniT/RXz6Z3EToOhJ6t9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiR65Xy9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiR65Xy9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746148390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBWfvLJxb5OXrN8DqbQaSB09FpR8x5OxSi6J4jIJ0dk=;
	b=GiR65Xy9GudezOJwIjRligP5jYtllLovq63adXuKBSVGKq0MYAIPxVUcLNznLIyLZApekQ
	duqGq4yZDZzVxS21/SC2e+hQUlJyeJmIncUyhsZXG5Y/9Ma8cCycy5zf3YO0/Qc9IsxmN2
	LvblP5TslguhFiK1LCSZ30GstgV/Uow=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-Fy2DpaNqOhWKFEPWblKGrQ-1; Thu, 01 May 2025 21:13:09 -0400
X-MC-Unique: Fy2DpaNqOhWKFEPWblKGrQ-1
X-Mimecast-MFC-AGG-ID: Fy2DpaNqOhWKFEPWblKGrQ_1746148388
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-73c205898aaso1134446b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 May 2025 18:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746148387; x=1746753187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBWfvLJxb5OXrN8DqbQaSB09FpR8x5OxSi6J4jIJ0dk=;
        b=oCZQXATdPMT7JOwbv3DxkqeBa/M8/mGq++MUlsVlpRe5gCEb6i3X5VqQOTHiBvvgDV
         GeEODFaHXAkj33J/mV+FBYageZ7vSu6rm99bd5KLABrpEFxQEpBO4q2icuZ92559E32k
         Si669QPzOkaikF2KmiBFJByy/XeLp2/fqthpCdtIwwsc79XSabq1MYC1rpOlwBkeO7JM
         ke59cUEdTqbngpu1tOnEHvJRlBXkgD2gfMszaAtidthgjSZk3tHEGBMpcgL45lQt0ghO
         8W/uV/3OPAB16FUD1s1CEpYTdLNO/zgyz1YOUEN1aI8H732nDeXBaSy5xJZ8s0iHimyM
         /h5w==
X-Forwarded-Encrypted: i=1; AJvYcCVP/haHfk4n/Ph8UF/2a2ZEz5tC3r+ttnLnC8zuXvBaO7X5YL1ekdDaXWvnroZh5+1YMkGrvrxwFEOqfvZDQxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHIlY8rrZJVwrZxjPR/XILWn3qtCfXUHHWUdbM0fg+a2qM4sG
	nW+5I43es4LWbdE08ITvywpgfO2O3QshOu+9ABIZfDFRSKtvskbdaVxyFQ6As6XHsqbZEGQgn0m
	/f4Ram+zqKBcqMRs3jLEk8/3xQIbirGE1x7OqteWAtKSyCoPPSQvYQQ+YYZ6mhY5x7A==
X-Gm-Gg: ASbGnctz/SPAVEiw4k9hVQXryJ1eV5ZbreAH6D00mb5ckhKSh36gX+gydbZmN5H7SOR
	u+N3SwNLk4b7uYKZJ/mPlG/rzVR4zy3xccWt036goAlg88q5x3RftrdVIFBvaJxP5yNqPxKQlxM
	If4xf7MorCUT4xgcloRVcQ9NsXZc46nMe0gtaSUmqBCthTUIAp3XSmfCqRjI9TkFGFY8BqL3ONl
	3StxoOgnpG5qm3oWWwwE19qvek9kmO5FH+3uvukhwTx2HbOD8qU0z8rVBoScndsFA+pUBlG175+
	a3Q=
X-Received: by 2002:a05:6a00:ab01:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-74058a1af41mr1713814b3a.8.1746148387363;
        Thu, 01 May 2025 18:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWrlVfaGnH2bAuy9TSvG0bRVxSTF2k5lzCQyD8yusIUmdWs3IYHq0T9Uk0I4GD24HMDP8szQ==
X-Received: by 2002:a05:6a00:ab01:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-74058a1af41mr1713773b3a.8.1746148387017;
        Thu, 01 May 2025 18:13:07 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7adc9sm347612b3a.30.2025.05.01.18.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 18:13:06 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH v9 3/8] crash_dump: store dm crypt keys in kdump reserved memory
Date: Fri,  2 May 2025 09:12:37 +0800
Message-ID: <20250502011246.99238-4-coxu@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502011246.99238-1-coxu@redhat.com>
References: <20250502011246.99238-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TbvKFSa3i-iMh7VHh4r4ZfYCmavmUBGSYl_xPrvG4v0_1746148388
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When the kdump kernel image and initrd are loaded, the dm crypts keys
will be read from keyring and then stored in kdump reserved memory.

Assume a key won't exceed 256 bytes thus MAX_KEY_SIZE=256 according to
"cryptsetup benchmark".

Signed-off-by: Coiby Xu <coxu@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h   |   6 +-
 include/linux/kexec.h        |   4 ++
 kernel/crash_dump_dm_crypt.c | 133 +++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 44305336314e..2e6782239034 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -34,7 +34,11 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
-
+#ifdef CONFIG_CRASH_DM_CRYPT
+int crash_load_dm_crypt_keys(struct kimage *image);
+#else
+static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
+#endif
 
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 1871eaa95432..6e688c5d8e4d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -405,6 +405,10 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* dm crypt keys buffer */
+	unsigned long dm_crypt_keys_addr;
+	unsigned long dm_crypt_keys_sz;
 };
 
 /* kexec interface functions */
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 62a3c47d8b3b..fb25f55f1512 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -1,14 +1,62 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 #include <linux/configfs.h>
 #include <linux/module.h>
 
 #define KEY_NUM_MAX 128	/* maximum dm crypt keys */
+#define KEY_SIZE_MAX 256	/* maximum dm crypt key size */
 #define KEY_DESC_MAX_LEN 128	/* maximum dm crypt key description size */
 
 static unsigned int key_count;
 
+struct dm_crypt_key {
+	unsigned int key_size;
+	char key_desc[KEY_DESC_MAX_LEN];
+	u8 data[KEY_SIZE_MAX];
+};
+
+static struct keys_header {
+	unsigned int total_keys;
+	struct dm_crypt_key keys[] __counted_by(total_keys);
+} *keys_header;
+
+static size_t get_keys_header_size(size_t total_keys)
+{
+	return struct_size(keys_header, keys, total_keys);
+}
+
+static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
+{
+	const struct user_key_payload *ukp;
+	struct key *key;
+
+	kexec_dprintk("Requesting logon key %s", dm_key->key_desc);
+	key = request_key(&key_type_logon, dm_key->key_desc, NULL);
+
+	if (IS_ERR(key)) {
+		pr_warn("No such logon key %s\n", dm_key->key_desc);
+		return PTR_ERR(key);
+	}
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp)
+		return -EKEYREVOKED;
+
+	if (ukp->datalen > KEY_SIZE_MAX) {
+		pr_err("Key size %u exceeds maximum (%u)\n", ukp->datalen, KEY_SIZE_MAX);
+		return -EINVAL;
+	}
+
+	memcpy(dm_key->data, ukp->data, ukp->datalen);
+	dm_key->key_size = ukp->datalen;
+	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
+		      dm_key->key_desc, dm_key->data);
+	return 0;
+}
+
 struct config_key {
 	struct config_item item;
 	const char *description;
@@ -130,6 +178,91 @@ static struct configfs_subsystem config_keys_subsys = {
 	},
 };
 
+static int build_keys_header(void)
+{
+	struct config_item *item = NULL;
+	struct config_key *key;
+	int i, r;
+
+	if (keys_header != NULL)
+		kvfree(keys_header);
+
+	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	keys_header->total_keys = key_count;
+
+	i = 0;
+	list_for_each_entry(item, &config_keys_subsys.su_group.cg_children,
+			    ci_entry) {
+		if (item->ci_type != &config_key_type)
+			continue;
+
+		key = to_config_key(item);
+
+		if (!key->description) {
+			pr_warn("No key description for key %s\n", item->ci_name);
+			return -EINVAL;
+		}
+
+		strscpy(keys_header->keys[i].key_desc, key->description,
+			KEY_DESC_MAX_LEN);
+		r = read_key_from_user_keying(&keys_header->keys[i]);
+		if (r != 0) {
+			kexec_dprintk("Failed to read key %s\n",
+				      keys_header->keys[i].key_desc);
+			return r;
+		}
+		i++;
+		kexec_dprintk("Found key: %s\n", item->ci_name);
+	}
+
+	return 0;
+}
+
+int crash_load_dm_crypt_keys(struct kimage *image)
+{
+	struct kexec_buf kbuf = {
+		.image = image,
+		.buf_min = 0,
+		.buf_max = ULONG_MAX,
+		.top_down = false,
+		.random = true,
+	};
+	int r;
+
+
+	if (key_count <= 0) {
+		kexec_dprintk("No dm-crypt keys\n");
+		return -ENOENT;
+	}
+
+	image->dm_crypt_keys_addr = 0;
+	r = build_keys_header();
+	if (r)
+		return r;
+
+	kbuf.buffer = keys_header;
+	kbuf.bufsz = get_keys_header_size(key_count);
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	r = kexec_add_buffer(&kbuf);
+	if (r) {
+		kvfree((void *)kbuf.buffer);
+		return r;
+	}
+	image->dm_crypt_keys_addr = kbuf.mem;
+	image->dm_crypt_keys_sz = kbuf.bufsz;
+	kexec_dprintk(
+		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
+		kbuf.bufsz, kbuf.memsz);
+
+	return r;
+}
+
 static int __init configfs_dmcrypt_keys_init(void)
 {
 	int ret;
-- 
2.49.0

