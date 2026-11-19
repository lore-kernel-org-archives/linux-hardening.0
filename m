Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116339;
	b=O0Dgwd55hp0gv1dnNiR7Cgk3m1r/PlPgxj8JaJmotdpLAHe/l3olPJxzef5RwhKuK3jG
	 xxPYYCadfZMPiN2fzaJepQwaUc50mxRob/E+sonE1yJOLgWZmaewixGzzbJKyDFQG+Nw0
	 4wp9Mc9RJLOj72SjiqKe7U1pNoRiy6mpRJTnOGEr8LqNx+dAKOzBqP9zIU/+YddIjCSjL
	 rpZx02Z19jr1C74/mjy1tnD4nNY1I5sPD1YWULTOFK2844pssDmWM9O+tiHH1Bycf7vnM
	 CTV2D0TG3VAgzlPFQB5JO63Ool0+s3QhEzR/YnLi3IwbMqPvhPJmFjNAs2hyGMUrbMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
	b=dybMNEMjAOiDWA8OguOYyUFeWXEcROdAe7KRQD+fHtEqeGR/lVKUgqhwd0iStnNvr+XO
	 edk0imMexB0txmN9ZXItl8cUzkEIt1/ysnR4dWGUF8EI+4GP0c7fh5Hn9LQ7JAbYJP7JL
	 DHOS83LT0tfom2xByF9FO59ItLzdJlhKBeKeClkoU0ZFvbuFum8eOE8JTZ5KoR8UBjNi8
	 E3vWvnAOkF2N0XUqSwFmHDn29otaeiUbCHuSX9w2l9lpmGBB7aaSjXiAnEnVboTpzK1ek
	 8n/YpDDrZ67bcZW+oOXwxoMvpwEWiOhLusjRKgP3BdAsawZrIO/xOY8hjOE2Ogi7soA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="nkk/aHO+";
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8A60A2604
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 19:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B8A60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nkk/aHO+
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-5735cd94235so213374b6e.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116338; x=1795721138; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
        b=nkk/aHO+iL/QVslKweTpGRJyta8pMKUanDqzsOYLUoHxYvHbcPk0K1oPjzbmUIgX5C
         a4ksEvuUXVb4knCRuLE/pngJN0Fu2U7Ksnr/txK6kZlULF0dMIonkXOHbeOOy6kXkLF0
         hVfNMJ3zBFp3whK2WapWwlMlx+6npAGmfKXoz3p7CihvOHcneCzBcGa76xjoOS4s2x8p
         V7MoBox3I5jV2aUG934ychxiasYie3HbUjHiyYnzAIkJmMHZ2tir8L0UT57NTHVWaibf
         +6uN66iZBFfXTXXFMLCcqQ9E/Qx4vuSInlbSJ/WlGdcn6yjZQcoU5sQtMa7Oi6dIP0VC
         1Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116338; x=1795721138;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
        b=PCGqEoN9Yf0V4IWS2wdWAcVKtcsGoXcgvRpsYnUTL/IA9z1oGR42lTSHlNfxx8OtES
         aB9g/0pXhXhqmhMdjtBwE5cw5MSjMa/BDxsXGCL2a3swK1Lw0MUYAOyXWYNir/X5oMFT
         Qx/YpUaUkVQ32Ivvbsw5yAbusGisrkZd0xEJYXwcoc5Zlk5WORKbkVhg7gEza+BPIzvv
         FA5WSCRIFK3vNftEkDxDYDIpXr/D9Qqzxenabo1LhQe6V4nGRzAYlunJkBb86Kccigrk
         9n22wa7ne81g2iuTNJmSOzFf5/4WleFDhcZWJD/dP6J+cIkIgDqHDB08PGMAuqm8rZ1g
         3Wbw==
X-Forwarded-Encrypted: i=1; AL+hErHe1UlkuKI5ce/QOiP3VbTh4FjMuIRCbpzsVjJlbYkxhsRxACCLza0XBAfsvXgEYUsLqd9DYpVgr7O4N+t9+R8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JS8sBTrMEhOZSRxvHLc7LjLOJnQ7tLnl+dbmpgoekGNCgnIbH
	9/WPlFp6fIcxrWkDKvs2KRbV0InQRxF5Yvkl1EzvcfzMEXM0nM4fN0Qa2Mk2d37pq545+LZyy0Y
	xRrrao+XHow==
X-Received: from ilmp8.prod.google.com ([2002:a92:c608:0:b0:51e:1b8:eceb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:c110:b0:576:4595:9836
 with SMTP id 5614622812f47-57a0ba52419mr994155b6e.40.1795116337420; Thu, 19
 Nov 2026 11:25:37 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:13 -0800
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
Message-ID: <20261119192520.1983406-3-irogers@google.com>
Subject: [PATCH v4 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
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

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Reviewed-by: Srish Srinivasan <ssrish@linux.ibm.com>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.1.708.g77570a6a1d-goog

