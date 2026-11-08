Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177594;
	b=QeArCsL25t0Ob3aF3XV9zNr7snEfOxwc+olEzuxXl2RjJTC4KtN2ijrQP9ZPO1OPSj8r
	 AOfFL0oK4PNDwPc21tX8HAFDGH3u4+2+5/HIpcZAefNPjNmLUBMgz8Oi16ok4x63Bsj/t
	 lDzuBctyRviKCz2/bNqsOJeF4zZUMBJqnuucE3LCoIpcCQCsxsfcv04kL9AxY9nwWJ63i
	 o+vLj7OT6BIRHNJbkF9+gPmSeJUzGlaWMqzRSFTu1AjGzouF9LRt/aCalO9gNaUA9GW1h
	 HgWUEkVlkXPV9ZpMgIP1HKOzO6oniLfzgduGEGaxP+BeZeOpIDXN7YDnPzea1VCDXIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
	b=sBjRHOYGAx2VeHdJHX1eZhD/ldDqNOHtBEUEl5AWYgrNTkR1f9ArIY27LF5xKhui8qDX
	 Xg+NOAyrUuFRP+OeAwW9i09nOxyUgEpdFbD9V3JCLtWCQiR3JMqx8U25nyiTpjySk3omz
	 hlWOiTHI3exOHZb3cbioUc+fwI9H/q8+C20gOXcGKlDTW4+5Zg0rpDc0cZ46Y2zeN6FSX
	 +XnOnGJXaimmluFYLaW8BK9pQXxdVkUc2JuChJKlonnQF0nPqZVpw1my8/7Io5X/9/HDm
	 /frlHOTH/F0OqsUcWTRMFCpRbMsju2tyC4MYsmfyOVx9K8heyb5uXoIuk5Sxh83ihsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=llvOaPqi;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920586082BD0
	for <linux-hardening@vger.kernel.org>; Sun,  8 Nov 2026 22:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 920586082BD0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=llvOaPqi
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso849396eec.1
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 14:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177593; x=1794782393; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
        b=llvOaPqin1/SJfB6ZgFMe2gZlVxb/SBs/EaTs1fBKHfuzR50CINutw+BhBVS4Yoq7W
         5CXnEaThdYdL5TvoWqX15XutB2hMeCk29e4XomOv785G6Jh+suNlIc/tIlBx15llRc2I
         7uRNwYJ/0N90oxF98NQiqNkC20zP5itEJJ4BwqXqG0e7b1e+l7tNHYfNbR8/BduTBQD5
         oLq+xpYDpQZXCZHJEuqL2pIcKw2++sMVfz4Vbcj5u6SlAk5GbzYVqVLZdDpxzAfriS7J
         4N8BhX3YQQWKNEv0Sqfj1nOKVxXqDF+/c8+GbvUOaS7b6Hf0u31Y/8hBrb5MMmG+oRGo
         r7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177593; x=1794782393;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
        b=eZpsDWAVly4pNDGIFJbe610QFrZBB1u7kztUKI4MM2NaJYAJmiBLsiw/Qy4uJH4aJF
         qpMIq0qLV08Vmy50NYLIaKS0k3gU8ju1CkAeuz2TTPoLaFXSNQkFOLgojPeW9RXQxNsY
         nuCwQUfFUPlKUJjUMSLo7U3nNm10qs/+4fNsR8My3ql4gpZZdcv93GLujUPr0gBfYhAt
         IeohHfiSMa5q+mPt0vK0R9QAQvhnZ54qtk+k9rt5KjPBU5ixL6ILKD2ZUNomioZJQPYO
         0A1aFtLHiUBuwZXqGMWhOUEsFSLrIMSxk8tllTj9n3zr9KQObHH81i4Pehp0sQLTGHEN
         RRSg==
X-Forwarded-Encrypted: i=1; AL+hErGRRyVLQKMqVrWvaAz9Eg2Fpiv89WhjespHnWtSc7Dw7yDg3W7DJ8m8qtcrAtHmyMat5juKRocFO9mld1pxZDs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+Z0/XIIYz3uUHRsXJhY2RzWEU3yeG9gLLpnHzc8g67qW3bO6A
	tpZGVgWCas6OGeN8qcvXs4HAoSRC7BDPpclol29rAkd3XUqWZgmwcDWYAWkDyRtTqGNE5IzF4ze
	Y5UkrRwE0Ig==
X-Received: from dlam9-n1.prod.google.com ([2002:a05:701b:2089:10b0:195:beb6:14cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:28b:10b0:1b0:430d:d81c
 with SMTP id a92af1059eb24-1b39feab6a4mr3897188c88.25.1794177592505; Sun, 08
 Nov 2026 14:39:52 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:10 -0800
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
Message-ID: <20261108223913.3624571-7-irogers@google.com>
Subject: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
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

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.0.455.g6c5a503b38-goog

