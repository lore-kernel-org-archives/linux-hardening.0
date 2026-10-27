Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140759;
	b=uaMgDq9tK9++bDTIgGHl0PHCys+qUzztcrg6N05uwhsmfGtqQBQcS34+dh6RQWPRoQWk
	 IC+l6XfR1ZhH2K3f25UkQ4qB2vpooJkb5MWD4N5nRVPwSmbOF0QE7sRwj8wZI3kLUzW5f
	 Lco73/v2BVBdYqKcm4+D7Z4g6e9xhsvrzfs0SUexZtTRew1m27D2dA6Yjeb5mzXTx5JWH
	 gOl13XstqJgtLdX/DF+kKyPbN1BO3yhvXWf+Gd8GwJig9fgP5KID5y5cWNq1ikoAjvuS3
	 ijb05GONMZUumv5+117sMp7Rsvc0liXwBr99ezpEDIiUvrNDqD0EaMVIG7G2NQLemqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
	b=V+gu3UiVkVdFrPSmPBSgTvI7PBGdvqGvR7DLv0MXf3EEGDn+btePB1H70LJTykbtJtEj
	 /4ojNxLnUUoCNEAVTWL2oxc/dSUo+HKblTs0P90Cz8Ugzu3AhRt8xbfDyWxyw5rHKwBBT
	 lmPosdOnkCTCY8j0HGd4EqtuIwl4KRx9LbhsN34AeAZ1iFQGg0ppiNRZ6aDQx8rYY+XNR
	 bKc6S30+xKE0cBHL/nmrphZg0XLk481ineWtZBuS6DoOBNf1M+QS3kNcgQ0CUkttLup7/
	 PR0F6D10BFovRDSgwwFymUR2S6rgZKkfz87FRHGYnuNVEBXkq/u2ML2WxVbaWE2dxqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kIMyUKFu;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66F60A260B
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 22:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B66F60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kIMyUKFu
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a0592d4539so466537b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140759; x=1793745559; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=kIMyUKFukUJtjlCB+ZE2zh2lwo3GQV3z3dUYxV09PKjXw0ZjE2jeWA5BuL5r+QkTsS
         5ZzU/9piUKJLhgATzOW69XBDirJSfUNdjU8bimvi6t/U9+77eeZV3sUpzjATUlpkTsmz
         gq3vyWIGNK0zFjlANK5GQZMvv0vsQLSwO9CijSJxrX9Vh1ynVxUpyQR+qXuUOzTQNEd2
         vqFNVi+/m+qyeN1OsBM/7m5G51CLC9ESLC5hoKgrvebdkKnbj7QYKY4thO4WPGJ0SxlV
         i2/3GcwAryD5MX3hH5HdRpHDIt1i8yx0VLeoNGibsE95Q6GYl69dtaAIBjedJgq+ugfg
         pXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140759; x=1793745559;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=YFVEIv/AoG/7RuRETvc4eHLmIvDPTdTHH4SYM9hsVeYPspmkW1SOVw69+/hcIJgV8q
         MyKUumpFq09FAQjNzmULsaDVCebctMf1iptHXMSNY2q7V2OHavrlRT5S1sc7qPZVo96v
         GeIijl1qYKUby+eynPjcAJxSHFg3DiBxJz4D+39luwTs766c01VBz00shHFdu2+bSz6P
         9SSOjLdXmJwvPQHqkSz21JKVOEVtQZg6hm3jBemsJtrA/eNFp/POgQBabUb8+Pg84MUW
         5vKlzAosDN8A4nKx8cw7H0XhN8MciM+O4rvAvDtjvQnEKIW+GPdGp+CIDKWeRjRXAiSx
         Yw6A==
X-Forwarded-Encrypted: i=1; AKwUvBzUFQA2BGZOZh+BAiOMJ4iJT1DDaKEV0qBrbuqjIgP59OVId/Y5qAyichb99jtXIZ35tHpGcha49StXswt5y9s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIS0sbynnSeHTfBxlgXo5ZFzC4xwbj2Z6Ez4+/iq+Dl4UpNGWJw
	EIXLAvhof7TNPV57V52r4CCeg/l56MLXPXCAA2ZTaIkosMzuP1R9HIPGOojTxTozZD/OnLvn7u3
	yjpDuRJQv9w==
X-Received: from pfbdw21.prod.google.com ([2002:a05:6a00:3695:b0:89f:827e:eb47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4293:b0:876:194e:b8fe
 with SMTP id d2e1a72fcca58-8a6e70e832amr492696b3a.26.1793140758450; Tue, 27
 Oct 2026 15:39:18 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:38 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-4-irogers@google.com>
Subject: [PATCH v2 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Mundt <lethal@linux-sh.org>
Content-Type: text/plain; charset="UTF-8"

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..f33864958487 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops = {
 	.store	= sq_sysfs_store,
 };
 
+static void sq_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static struct kobj_type ktype_percpu_entry = {
+	.release	= sq_kobj_release,
 	.sysfs_ops	= &sq_sysfs_ops,
 	.default_groups	= sq_sysfs_groups,
 };
-- 
2.56.0.313.g2479322e68-goog

