Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116355;
	b=DOQUQ42Z4qFDBssRJJ94L8ag5osleoyY9EQjDMCiN00FCNP58txvsjHajokndQ8Hm7ur
	 OWTVE/5kFmMbN4Z6zb0No00+GfTU044vJGbjeli3jfg1F6DXgMV+m2zzgKnxZGVLbNNmP
	 jT9wZQmeH87jJywlh0mRa4iYhRaXtEPCmp1uOdxjcSXAsfAVK8SHLbi3LNZrciOQt0R2k
	 qgV3Ebg6FyGsA7K3mkj/ebX2iS6i7Rb650BTDkJ+Gez3JcXexNA6DUco1ZcgZvYs2To3T
	 iwnVwd5ey6iy0aNLwRWnNfBiKgO03Ry4lKgh5PEYYTFxCTPE4tT3n0IP9L+IfATscjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ohgce9vn+z31zJY1A4d/uIcUdw7UhPIFGYmbETxOr2U=;
	b=qh4HmzKOBsAAJHE5c89nl14ltTTRiVvtKllNssmRHLGLfoYlhduIw7JOWO9sIe14TC/d
	 V9+T/uefgYcLsKa2nja78czlnkBpWN8JBxIM+181HuVz+H5njcId1BpstlirKS26mGMrL
	 fWiR/6fre/5SR1DgzhTXR13BRg5dgz3U3imTVIkCpewgrT/teNkgtJ57PEemzdDvFTdeA
	 Q+h3BEVU0d8Ja8S0yOZ0XVvb5fwIpcYHcaEal0J7x6R0oFmbEaZkAm01EwGg9vuWFn+4X
	 bNSdFnEnnyQGaD25cz9rBncd3BDluCsAZlAvK5P8v4uey/3X3YB7Lm2LWOCAtN5x9Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="aB/0DvlQ";
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583460A260A
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 19:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A583460A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aB/0DvlQ
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-5713cd0fb42so1691286b6e.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 11:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116353; x=1795721153; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohgce9vn+z31zJY1A4d/uIcUdw7UhPIFGYmbETxOr2U=;
        b=aB/0DvlQP+ZekEZL6nGv3o95jUff8I5mdjyfTxhGHBLr5vPRW92RO4Fu5/6A6cq3wJ
         UIdHk/SAR8OEsG24eP2FCEyqUArUYTP+6HPy9z+i173rTQQ8PRep7f45nkL5+qZkPSUk
         s3yiWj7hk6GGKR0ju6FFBEUJz+pgIwdmoKsYCRB2yMVwAWMDEZpEQ0i+eRXzXGPPJW8u
         keKTiUkUdH9FEpWr+/3+d7zUOdVx9yVsjCPRO2ZSs9fhdOSBlzq7YxLuFFBUipHM2LXb
         lQILbgl7SxZhhsoLORUIebAB+ozK/HoiMVFNOvUPp6nYBRM4xF4nlxk/A4aIvbi/qTwD
         ZwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116353; x=1795721153;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ohgce9vn+z31zJY1A4d/uIcUdw7UhPIFGYmbETxOr2U=;
        b=qvvmZsfuURqEPfbBU3rp/0fzK3ouXEHodGq5sUILsS3NTVjasQT5AnMZtyJSdIaj68
         wUkWkuE8aIl0lj7z7pf485vyUs6iLHpRNyRa5COSlBTN7NNamVUEwVe4JXkIC9z38RtN
         Ha6y7qK7OvoBTOPdyppXjeOtfRgw//U+4M0p5KcIejAU3HQyfhUkMhKjbYZx5YdQG/z+
         Eblh1IE+cUzB/IFzwYA17xFlXUJ7Tea8n0/fEH3bNp4HS+MbgJEbWx+bXD0pcuVbk3cf
         ehLPslhs3P/MRyQZKoIopBMm2rXg1gPNlRKeKWI0TfmsDEpM4j2ws2xk7gL3vV0lB7YC
         WtbQ==
X-Forwarded-Encrypted: i=1; AL+hErEjY1byl7zPbiYsIsMp8oBk1qZS1GBxWxWaU34qkviSM3jJGkIb0SxCw3BnA3gHGqaq3lBPCH/CxYfQVyiUMvE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2f9y3XoLLq1Z5E39jI6GWsB2SuZkg1p3LrM5EIYif89Lym/GZ
	UnOHVPrUvgrisgIAR5S9GR3YvOY5FeI+buUqQ3muQ0j7/hvYdl3naCEU6zJDfXqbqrSt48ZomAe
	ohtQ996eDjw==
X-Received: from ilbdx27-n1.prod.google.com ([2002:a05:6e02:421b:10b0:547:8b66:16bf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:2383:b0:572:f8ec:5340
 with SMTP id 5614622812f47-5797dd97e12mr1569173b6e.40.1795116353256; Thu, 19
 Nov 2026 11:25:53 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:16 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-6-irogers@google.com>
Subject: [PATCH v4 5/9] dlm: Wait for kobject release before freeing dlm_ls
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
.release callback and dlm freed the lockspace structure directly via
kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=y, freeing ls before the
delayed kobject release runs causes a use-after-free, and unloading the
module while the delayed release is pending results in an instruction
page fault.

Add a completion ls_kobj_done and dlm_ls_release() to complete it when
the last kobject reference is dropped, waiting for it in free_lockspace()
before kfree(ls) and in the new_lockspace() error path before module_put().
Also delete the kobject via kobject_del() before stopping dlm_recoverd
to close the window where concurrent sysfs writes could wake the stopped
recovery task.

Fixes: 8a4cf500f1dd ("dlm: drop kobject release callback handling")
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/dlm/dlm_internal.h |  1 +
 fs/dlm/lockspace.c    | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 74c2e77d1b55..95b3bff0cb57 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -576,6 +576,7 @@ struct dlm_ls {
 	int			ls_create_count; /* create/release refcount */
 	unsigned long		ls_flags;	/* LSFL_ */
 	struct kobject		ls_kobj;
+	struct completion	ls_kobj_done;
 
 	struct xarray		ls_lkbxa;
 	rwlock_t		ls_lkbxa_lock;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a9c98b4f378f..2dccd080a10f 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -179,7 +179,15 @@ static const struct sysfs_ops dlm_attr_ops = {
 	.store = dlm_attr_store,
 };
 
+static void dlm_ls_release(struct kobject *kobj)
+{
+	struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
+
+	complete(&ls->ls_kobj_done);
+}
+
 static struct kobj_type dlm_ktype = {
+	.release        = dlm_ls_release,
 	.default_groups = dlm_groups,
 	.sysfs_ops     = &dlm_attr_ops,
 };
@@ -355,6 +363,8 @@ static void free_lockspace(struct work_struct *work)
 	 */
 	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
 
+	kobject_put(&ls->ls_kobj);
+	wait_for_completion(&ls->ls_kobj_done);
 	kfree(ls);
 }
 
@@ -435,7 +445,10 @@ static int new_lockspace(const char *name, const char *cluster,
 	ls->ls_lvblen = lvblen;
 	atomic_set(&ls->ls_count, 0);
 	init_waitqueue_head(&ls->ls_count_wait);
+	init_completion(&ls->ls_kobj_done);
 	ls->ls_flags = 0;
+	ls->ls_kobj.kset = dlm_kset;
+	kobject_init(&ls->ls_kobj, &dlm_ktype);
 
 	if (ops && dlm_config.ci_recover_callbacks) {
 		ls->ls_ops = ops;
@@ -567,9 +580,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	wait_event(ls->ls_recover_lock_wait,
 		   test_bit(LSFL_RECOVER_LOCK, &ls->ls_flags));
 
-	ls->ls_kobj.kset = dlm_kset;
-	error = kobject_init_and_add(&ls->ls_kobj, &dlm_ktype, NULL,
-				     "%s", ls->ls_name);
+	error = kobject_add(&ls->ls_kobj, NULL, "%s", ls->ls_name);
 	if (error)
 		goto out_recoverd;
 	kobject_uevent(&ls->ls_kobj, KOBJ_ADD);
@@ -582,7 +593,7 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	error = do_uevent(ls, 1, 0);
 	if (error < 0)
-		goto out_recoverd;
+		goto out_kobj;
 
 	/* wait until recovery is successful or failed */
 	wait_for_completion(&ls->ls_recovery_done);
@@ -600,6 +611,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	do_uevent(ls, 0, 0);
 	dlm_clear_members(ls);
 	kfree(ls->ls_node_array);
+ out_kobj:
+	kobject_del(&ls->ls_kobj);
  out_recoverd:
 	dlm_recoverd_stop(ls);
  out_callback:
@@ -615,6 +628,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
 	kobject_put(&ls->ls_kobj);
+	wait_for_completion(&ls->ls_kobj_done);
 	kfree(ls);
  out:
 	module_put(THIS_MODULE);
@@ -740,6 +754,8 @@ static int release_lockspace(struct dlm_ls *ls, unsigned int release_option)
 	    dlm_user_daemon_available())
 		do_uevent(ls, 0, (release_option == DLM_RELEASE_RECOVER));
 
+	kobject_del(&ls->ls_kobj);
+
 	dlm_recoverd_stop(ls);
 
 	/* clear the LSFL_RUNNING flag to fast up
@@ -759,8 +775,6 @@ static int release_lockspace(struct dlm_ls *ls, unsigned int release_option)
 
 	dlm_delete_debug_file(ls);
 
-	kobject_put(&ls->ls_kobj);
-
 	xa_destroy(&ls->ls_recover_xa);
 	kfree(ls->ls_recover_buf);
 
-- 
2.56.1.708.g77570a6a1d-goog

