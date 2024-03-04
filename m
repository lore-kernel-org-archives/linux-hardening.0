Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7679921
	for <linux-hardening@vger.kernel.org>; Mon,  4 Mar 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578182; cv=none; b=GMvHdyxnqzK0/LCdjZouB8HVgUz74LMuRpN4CVeCL3uDf02L1K5M5QD6rG/FvOBcCJT/3InpYF6Q2C4CkB9JOoFLnhs/kpz4ogtwMVT8YM1V5jBAUxP3/5TBBrhsW/1jryTC04oEM0eqsmbVdxfP2P4TFiRADj92TEOi6Pkh8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578182; c=relaxed/simple;
	bh=IcLElAry6DIoRKKwJQmpd7ju+FKDVUugrCBgj64Jc1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fV27Zn9qxV18CWLpmVUDu3UdPNAdKZze/AiXZuQNiJUHg24GzzEIGy4QETClHiuyn84cgY3jSSmSy+/C92IcZ2PYZfdo6LWpU0CZdY3FoSSudPCHYMtCKdQDCM0ikkqKF3RuSXytpqUXgGYJvdZaPqkc9FTSg0NhyEBJqUeOsiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FjOMYjnR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FjOMYjnR"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6092a84f4so1263348b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 04 Mar 2024 10:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709578179; x=1710182979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QOKxvJdszgSExOijEeIBqvAxDpXCtl9o7KCQ12P01Y=;
        b=FjOMYjnRMCw8a5h5ArmSEPQ6udrpaxW+1c0RexEdjfVm9cpDln9PewKj+qmiD09/rq
         jbSGrBJ9sZAN6kkLxylO+qxRHMFx0vrQQZyEoWwU3VHNHvjNflgYvjbKKAz2C2Lc5c9N
         Mn/XvuCQamq9Qf/t1fVTySzbuf+Sr8pTRa+CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578179; x=1710182979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QOKxvJdszgSExOijEeIBqvAxDpXCtl9o7KCQ12P01Y=;
        b=IdPlY3rwtARbeGgNSiftK4RfD0JDuqosBI/7f3UBA2E77+fGVDO1c9GQqN/LYIUJRi
         6grg5SxmJfllGa9Pykw2MzZ8/e0bw89xdAw+WuE5ljRh88VWk4miyzQBoK0dc0BX7Pzg
         F2GW6HW3ggrevK4C2nKRWwaSG/5sOK79jIFmhTWuBiFqpmMnZoqKoUsrn6u7dN6NAloA
         7GWpRxFLAVvk/4dXx/RYXfspJDZZL2hfnqCeBdybKVWk9xt0BBQrW60ogT4XgcvHhUM0
         dMjbymOuGwCek9eno254QdLwGPzD/PTpWyjfpLx7Mu5KuAp8H72C+KvmGQ8Xf2fyslV9
         d4wA==
X-Forwarded-Encrypted: i=1; AJvYcCUL/DwGm48DxxZg9GtZfq9MT8wHj/44MqRXxtm5NVEe8mvaAcJpmcklECx2pdMrpnkAqu15Ne48GfLU2O59Mke2EeAPC87N/zO3iq1DsLwy
X-Gm-Message-State: AOJu0YzCIo+ToTP4u4/ZpLkD1CdPwZTNPK8tVaNhrN7mEcOyG/ZR4mqZ
	eUFiFVLhFu5xRUmxv+5eZkRy/+5aAocLJtJnrwKntUS3eZXKx8u2UuJ4qvDySQ==
X-Google-Smtp-Source: AGHT+IGILIudDoOhkhQCWTyG9z0DMQjNf1OD2uCgU2558fLWKJP3m4244pk1XqBrh1eKa3auyU02eA==
X-Received: by 2002:aa7:88c1:0:b0:6e5:5425:d914 with SMTP id k1-20020aa788c1000000b006e55425d914mr10540158pff.2.1709578179470;
        Mon, 04 Mar 2024 10:49:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r27-20020aa79edb000000b006e60c08cbcasm2881132pfq.50.2024.03.04.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:49:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/4] xattr: Use dedicated slab buckets for setxattr()
Date: Mon,  4 Mar 2024 10:49:31 -0800
Message-Id: <20240304184933.3672759-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304184252.work.496-kees@kernel.org>
References: <20240304184252.work.496-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=keescook@chromium.org;
 h=from:subject; bh=IcLElAry6DIoRKKwJQmpd7ju+FKDVUugrCBgj64Jc1w=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5he8RUV3Nml6+beLYoX/gI6MaxpEQEieiV1Pk
 LAMHZWkh1eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeYXvAAKCRCJcvTf3G3A
 JgarD/9HvGby2B7eoqRlayCbyDlLBOSIiVV2Bq+vUUsC8Ne0FV1zyqgFRQrXbQ2G6VGoWXimSlm
 M1jvsW/Y99i2kQDWqeDEZeZf+LehlADDm5Vd8pmJfMMgX19BF898FQYPT7s7OKOxOJ4T/GuE1Kf
 f8BRgEGLrWxyrMYUyG5/wFYfmfEzazDwiU+A/d2eMxhnYFT6e1elFQ0FweaUabd1+ZCJwV5UdWh
 HIyGFxL/YTavdVnf68HYBNALeF2lzUERVyzafZOv6WzhMzem7sDreYdkBpWwU4Nvafa5vCB+mCZ
 kz+tSe+uPkTDLUvM18O8w9hPQ0ywaf1CFBDkCciseVfUKVnH06WlWb84AbCwLv1KSDl6ipWRLxU
 84NhknBpAY4fgIguhU0kDs83NhdIl/kn10T/oubIkmY5wdavroHRaFjSlkw/VAeVdJCOOH+U3b9
 AJDGgUmwEUlmq7b731/mixhLBrz0CTKq8Aa59nDba3ji+Utrd7I1HKHwMPTcsPrBIVtK2QspH+t
 pcBzTrTkEuaW7vRD41WXoqxhSJ+mUK3+SKCFafsj0ZaMq2qMA977BazfKFPlNrWRRWzRrteGmk1
 Q8c9m2anBqS3EOtpP7bZ2OHyh5VlDQiLJP6Mo78p0Tkgsf+LU7XH1gWUSibuhbnTREFTie5DhAK x63js6NDKJKKoCA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The setxattr() API can be used for exploiting[1][2][3] use-after-free
type confusion flaws in the kernel. Avoid having a user-controlled size
cache share the global kmalloc allocator by using a separate set of
kmalloc buckets.

Link: https://duasynt.com/blog/linux-kernel-heap-spray [1]
Link: https://etenal.me/archives/1336 [2]
Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [3]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/xattr.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 09d927603433..2b06316f1d1f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -821,6 +821,16 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 	return error;
 }
 
+static struct kmem_buckets *xattr_buckets;
+static int __init init_xattr_buckets(void)
+{
+	xattr_buckets = kmem_buckets_create("xattr", 0, 0, 0,
+					    XATTR_LIST_MAX, NULL);
+
+	return 0;
+}
+subsys_initcall(init_xattr_buckets);
+
 /*
  * Extended attribute LIST operations
  */
@@ -833,7 +843,7 @@ listxattr(struct dentry *d, char __user *list, size_t size)
 	if (size) {
 		if (size > XATTR_LIST_MAX)
 			size = XATTR_LIST_MAX;
-		klist = kvmalloc(size, GFP_KERNEL);
+		klist = kmem_buckets_alloc(xattr_buckets, size, GFP_KERNEL);
 		if (!klist)
 			return -ENOMEM;
 	}
-- 
2.34.1

