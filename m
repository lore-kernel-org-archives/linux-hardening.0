Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DD35650E9
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931236; cv=none; b=cDR5Jw+XbtjHRdGeQZ7EzaqgZYIGWecZbr8/rrTnBKJWI6PGGHlJGTJ5WjEx1GbJ093sz3YiibeoiEtdlHJPv+HI0zsMP8a/1xcj7rdSqRyV9NIM8U362RXnIkWv+WYSddXa8+SbpJPOy7I2XXIThkPZd0b20VC7wyrXjn/QNsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931236; c=relaxed/simple;
	bh=CtncMESqzMmhRbpylMpIrDVzOLt3AaDiHb77RK2NC2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nIylFXA872VHYHmFs3+2RO5zGTlqvLDRiYV4QrY4nMMwv9AEVpgFWzBgqfqSY17ubxUCzxC+HqGEKlQtR6okj33wHkvnGmzDDH2cZrVhbLubvyb6Fd6vN4YdThjpNO+JjhzEQC3gDKsA7rlUPzZcU82GeW+gAEPjV795RjH+c4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EWCieHRQ; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWCieHRQ"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso6716191eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931225; x=1792536025; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbjJdHqZPRkvVZnH2yPkFa6V1wQ6/MdT39yYoogCQX4=;
        b=EWCieHRQtnymQ01ZM5dQGmfVpMClRk5Qc66fvDBi9Jlm5G8pHSyW00uZOQdfugFnxQ
         k3DyNLSxPbj0F1x1KsCI64yTsOSYJ+0qVOSCYpH3psM1cd/mLdDFz0pw+gvUjPo4LyuL
         5FhD/ytWCyR6ERSgmEh8skVWg7vI81QOUmrYraPHvcpit7EGlXx5VR+9oRyiUIa7CArE
         NVGTUVTLcGB5hDy1CL1duiUOhcSZZIw4YK8thK3hQ3EgdMbJxMlWg4Vb5X7AOntyf6Gd
         0IC1+C+SqjgSL2D2IuIKD8SWyvULp+xavM8jWOo3gSCsBE+SZycld5TLgj8GrkY19yBl
         pgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931225; x=1792536025;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wbjJdHqZPRkvVZnH2yPkFa6V1wQ6/MdT39yYoogCQX4=;
        b=rEtSW4SBIbxN0VFSaVylr5GJhcVei7KOZt9SOzjBbtUfBgjomwoUcuJZQFCe6PJfI8
         6/JxP77mzqQZC/Euliu+AL0ZGIjz2Xe9ue+xl/mWPfvduUPcUEDzpLMLwe2EdTJ5uIaL
         cbrUXyQwiWYe8mMvTxLo1mHS439ZoDNCLvw+xfiTEWuteDdN61SYKOl6Y+ZKZTS5dv3B
         1PD3lm0wSUDPd16o8FQhOqGBxO7PmGj4OYmb1EJNcg0Tjo2U2pCbopDDepCh/qJwtdj9
         rpS++Ey3TdNnuZQJzm2pBYqkxrfOEJlHqobRmpPcIn4q1eKdnEr31T/dsu8AUhxCxGx2
         pVRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTc/w3yFccT3RqC1SUS0xVfgwh8/yIC1PXwSDv7kM7ZwKtHY1VSIVRAXyi07TuKVxyfq8ly5gb24fp0e6SZVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLm2rFsVjHR4bucigzlA9WLRC+v5vgIZKe7sAgbKlFKlvlbO+4T
	RTKd5y0IiVL5IjMdikso4nfR3N+3SKTmn7VuidD6WaS8v/2cMJzG5NLd0xvJbj4toO1XFqzqXVU
	6jJuSea4vrQ==
X-Received: from dyr27.prod.google.com ([2002:a05:693c:401b:b0:359:e5f1:14fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:470e:b0:35c:73ca:a1e0
 with SMTP id 5a478bee46e88-35c73caae65mr4317399eec.15.1791931223446; Tue, 13
 Oct 2026 15:40:23 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:40 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-6-irogers@google.com>
Subject: [PATCH 05/11] ACPI: CPPC: Free cpc_desc in kobject release callback
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

cpc_desc_ptr embeds a struct kobject that is registered in sysfs via
kobject_init_and_add(), but cppc_ktype lacked a .release callback and
acpi_cppc_processor_exit() freed cpc_ptr immediately after kobject_put().
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free when
kobject_delayed_cleanup() runs on freed memory.

Move the sys_mem_vaddr unmapping and kfree(cpc_ptr) into a new
cppc_release() callback on cppc_ktype, and initialize the kobject on
allocation so kobject_put() handles cleanup in all paths.

Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/acpi/cppc_acpi.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fef54fcd00b7..2a80404f85d3 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -297,7 +297,22 @@ static struct attribute *cppc_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cppc);
 
+static void cppc_release(struct kobject *kobj)
+{
+	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
+	unsigned int i;
+
+	for (i = 2; i < cpc_ptr->num_entries; i++) {
+		void __iomem *addr = cpc_ptr->cpc_regs[i - 2].sys_mem_vaddr;
+
+		if (addr)
+			iounmap(addr);
+	}
+	kfree(cpc_ptr);
+}
+
 static const struct kobj_type cppc_ktype = {
+	.release = cppc_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = cppc_groups,
 };
@@ -799,6 +814,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		ret = -ENOMEM;
 		goto out_buf_free;
 	}
+	kobject_init(&cpc_ptr->kobj, &cppc_ktype);
 
 	/* First entry is NumEntries. */
 	cpc_obj = &out_obj->package.elements[0];
@@ -1001,11 +1017,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	/* Plug PSD data into this CPU's CPC descriptor. */
 	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
 
-	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
-			"acpi_cppc");
+	ret = kobject_add(&cpc_ptr->kobj, &cpu_dev->kobj, "acpi_cppc");
 	if (ret) {
 		per_cpu(cpc_desc_ptr, pr->id) = NULL;
-		kobject_put(&cpc_ptr->kobj);
 		goto out_free;
 	}
 
@@ -1013,14 +1027,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	return 0;
 
 out_free:
-	/* Free all the mapped sys mem areas for this CPU */
-	for (i = 2; i < cpc_ptr->num_entries; i++) {
-		void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
-
-		if (addr)
-			iounmap(addr);
-	}
-	kfree(cpc_ptr);
+	kobject_put(&cpc_ptr->kobj);
 
 out_buf_free:
 	kfree(output.pointer);
@@ -1037,8 +1044,6 @@ EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
 void acpi_cppc_processor_exit(struct acpi_processor *pr)
 {
 	struct cpc_desc *cpc_ptr;
-	unsigned int i;
-	void __iomem *addr;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
 
 	if (pcc_ss_id >= 0 && pcc_data[pcc_ss_id]) {
@@ -1056,15 +1061,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	if (!cpc_ptr)
 		return;
 
-	/* Free all the mapped sys mem areas for this CPU */
-	for (i = 2; i < cpc_ptr->num_entries; i++) {
-		addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
-		if (addr)
-			iounmap(addr);
-	}
-
 	kobject_put(&cpc_ptr->kobj);
-	kfree(cpc_ptr);
 }
 EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
 
-- 
2.56.0.385.gd3acb90ef8-goog

