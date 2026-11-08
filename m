Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177585;
	b=5fSAfSqK9q0C85/5mh2nwjeTjkddAfvylkQU0YSpC/NoFM7qKB7+EAfdskRl5vTfr3gJ
	 bn27+XhfsasLkWOozJxzWYPh8TAlaQZKhtAxZxmABKoPBUQZN1RdjtLG/AKayfx28Uqfd
	 AbTBBRPeLhaziBtXjy3JLym8M6v5tIe6rZO22RrFNjhoUbuCV4UugXOR9Azd9vYdx0Gn/
	 Fu0bDAMRgHtaqA7VZxfTjsW2xlPl5O2JdcGMJoP6d4OTOQA96wvebougwxXu84ENQOclG
	 h36IeHGoI4Hw4xzzMFWS9g29rkf3FtdmNT/OcsDh03lzMoPVQAHUCKAYT4Ca7E2SYHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
	b=f2z+VI92Y81hQWCeScxrVf2AgTMFlLvnss9WMESlHOy/6U0qIgW+Yf4Zn1XeYLlT5W+5
	 oZVueeVp3BFa/9wTNG8/OBBNxSRi34qOoOYPBzkWzXR5kxMc74PH+kojxTFGbYhlLtdXh
	 velreUWDJ6daMex7NHSeEMdq5gjt4BpxPXlMNLLxQfKCf+BEbk5SBf/5dswRi0arubRNQ
	 R5y7nDrcarw6cMMbfHVpOsvvOo5o7DpMi1DDP2wixFMsw+1/vG8E3ana1MTvyk9G1zI2K
	 J+eyUHwuLfxCQH3XTJFv1Fbz65PQKW2vy8lGFgkc1PZAZlV9zkDE9cjTwYHv8c9vGTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NF6P22Ua;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534AD606D82B
	for <linux-hardening@vger.kernel.org>; Sun,  8 Nov 2026 22:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 534AD606D82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NF6P22Ua
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b0d864826cso1320314c88.1
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177584; x=1794782384; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
        b=NF6P22UaPGr1HDfea9kIcWbvRKcCIqN8QEnwFDbKz7tk/YbwkvRrkeVgpGhGtL4pd4
         hfj9fQFfEsWjRGIU/+FpesE50zkmrNYtB0biAoRbXjgTG8kMFlw/AC5Ttr/5yXHV58NT
         pvVgwNyRYk/BerQZCNGYBlTcX/bdD89VaZWATi3zdy9xhnS3TijcKHBVOoyTt5heM+Ck
         cKpvfTO3CnEyaewDLme9eiHmbl56rQt1ycDdA87P+CCgihWAn4/ugTKalEaouLl+FTTk
         pJH/XwedfFvWkr1XlZ3RGbE9CRxI3L+P1FZ7lzjMyolBo8TwkVZOI96BhudO+UAAzah5
         6xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177584; x=1794782384;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
        b=z2trL1yAnlxhEpO/uy/TFC7EFrujfk1jRA2S+9OaPEiFeoRhim+CPTtC65GGt3niMm
         hZxfSXG9mi6gSgBeVjT8HVuC5ViQePhZu45lBo+w/o0G8VCZXyYOX+yZGL0dx9n+xETs
         nldeTPqPp8/tAMQ4XW31M7B7SnLsj7sTeNBxR7T1Zxib5Z9kOyAQFS41eUymqiAVkbiQ
         QJ4+klW3hnLbAO8MsseyvuN1cw5n4vzLkCvyIk2J3OLTci/nIh7Se+arYLjsoV+YmVuh
         g7+D1f2zBjGLzgu11YgMQV7NYkTufy52AHl9fLqcHtWKLJegZyxZoFrBks8FfdJhTsRK
         o9jA==
X-Forwarded-Encrypted: i=1; AL+hErEzDzXOwJX2A6hq38cDUcHnB3AMOzh4i88jX95CMCv8js4kBLdZzb89cFUZlRE7qsTyF9UolrAlyCgKYyaUSEg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tE2X+XjDW1kOBCKHXQg5B210KmKBt2xQ6AU2ychsOxbPE3PT5
	zAFTFzCN4A8w8pNqPPADxkyAA8Nl61PeG8jRJ+Pa+WcSyH0KEvwZNxpylgj75ZcTBYqEkmqslNx
	s5fLoyZnN6Q==
X-Received: from dlad1.prod.google.com ([2002:a05:701b:2201:b0:1b2:6421:f4fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea8a:b0:163:bee9:b250
 with SMTP id a92af1059eb24-1b39fedbec2mr3348910c88.22.1794177583902; Sun, 08
 Nov 2026 14:39:43 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:06 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-3-irogers@google.com>
Subject: [PATCH v3 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
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
2.56.0.455.g6c5a503b38-goog

