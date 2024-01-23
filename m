Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8114C15FB34
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970186; cv=none; b=n7dBB+aKVPndZu7V8mkyFlxJNI8DYy0caIaAHfBT+UlKQGA24gtL8VFArGVodIehFrEXeRJco/0ZNkhhMlKEzgdUBcFPdQSLlmiM4FodKF334jnbWax99zJtfUs2SQO/NG6WTOCuASR7i0+/7cByaUZZoxhLjdsnlpPtChp6EGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970186; c=relaxed/simple;
	bh=GiWhP3MrtF/n6FOjCeTrtngKdYU/XXg3g36941RXt68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcuG7m9Sdcjb4NzKdv6/mJ2Lt5e/7s6fnX1vPiivrbGqiWIKiBfEsomvvml1990n8DWa5Jol42/c9viKdoN4NL4/KFjDpC4jaUHg6daHSZC3WPCiV/rBOsSOiv6Ys1K+Si8d5nR/n3f5eRhAUBFbuKNydO2LEScoBRL61vO8Q4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U5w+TCj3; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U5w+TCj3"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-598ee012192so1640284eaf.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970182; x=1706574982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfUPSLWLFR2aaFBB7T6PJOGyzs3EsvCpQit0VhIc77o=;
        b=U5w+TCj3OYdJ3nUk8pG+3r3BOkuYEfZpnYKA1Uejeu/YHAIFIcQ8bYLtI08jD8If63
         Vb70yGwIs8rkcQGNU6lMVrr4DGaPiRVtqcd5ZNExuaKhqOGX5eI/mJSseo+3fSQp4L4W
         4bO8IH9mJJUWix5a+5biqdITiQcQcgDGyN8ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970182; x=1706574982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfUPSLWLFR2aaFBB7T6PJOGyzs3EsvCpQit0VhIc77o=;
        b=SIsRW4lawu9jSIJj+q3lOhHI8jrB9XZPqkOIVNem2b1NTLZ0sTiLHU6pakmVMKqcWR
         TeqEwkpFRSu93Ed04+lGkSlJxOxwdLCOtycaCFP6GwvVGPWOOgZND872PTeBYyXXGzGQ
         ctjEgI7SxY5OJdbAD5idazvSpn8gHl8dunl09m75CSUrISBYWlDkjD+4FvfCGr8mGP6G
         FQQfOztWjAWpt3aNdisGRHgGieSQgyuC1sx5xCitsmnfZTo+WY8CcVhfzejfkiAOpiis
         eJITccesEuUZPK/grOT1gnwj2bklpQJkqcWV7KAZAEFpK8Gz7ag70wO70K71+Zj6UkRE
         fQJQ==
X-Gm-Message-State: AOJu0YxJpd6DzhgSxNETpTABj2T5vHe1WjFysQzeyd38V+a1ZzU13yUy
	ype+MLESa/+ltkShFJV0U+BB5KdZ9PcRn2DCcHA4/qI/lMVzNG2jExEKxjuV3g==
X-Google-Smtp-Source: AGHT+IFWer+CHPYFKz4aogRg2rh9FM/Qdoj3c5YAE1QWiQ2/ARGjmNAbYrJIVCmUtb1J4VGTkYl8bA==
X-Received: by 2002:a05:6358:4b4c:b0:176:5381:7508 with SMTP id ks12-20020a0563584b4c00b0017653817508mr1802125rwc.29.1705970182669;
        Mon, 22 Jan 2024 16:36:22 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a62e802000000b006da24e7c16dsm10181497pfi.186.2024.01.22.16.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Martyn Welch <martyn@welchs.me.uk>,
	Manohar Vanga <manohar.vanga@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Alexon Oliveira <alexondunkan@gmail.com>,
	linux-staging@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 79/82] staging: vme_user: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:54 -0800
Message-Id: <20240123002814.1396804-79-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=keescook@chromium.org;
 h=from:subject; bh=GiWhP3MrtF/n6FOjCeTrtngKdYU/XXg3g36941RXt68=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMOyPanh0a8qKmM4y2TAR3HGUyEXSwoxVEk
 MEgKnhG10iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 JlyEEACa0F1lV4dIXFWgeCdkJHhSC7mnxnguEgyncSJiop+k0Bd7fCoJ6xCBI/VsrDDiOV5JO7h
 YlfkKkorKeHSwQ4eF7kA5ad0WAs43pP9aHx+fgnexAdyAv8q6kB4EV+m12jZXMkqpa1a2arGVBX
 vU/kVtSPYhonhrHCjR8yD/RJzZQCOq0Mv9L/oNW0TClnra68UXFMsMrx8r02ANI98S3Kkm/fePG
 YWRN7tYvnoXzmS1Mv+bd4pACK3H9sNQQa4gC3fsjOQTevRfKf/goaHyRRd6b7JoulGhmmzXXtZr
 OFWkOtLXFLah6ZOtxrTfcxSwwBuPTZeJrkLQlwBkjxPZoZU7IR5rhIfBgONwxTkOAmv0aR/cRis
 kfuHPvu7SaQ6xuRNFXVsgmqxwWDG19eC/B0UrD0D1lhkRNPRS2OqC813G9hba/iMw+CpRd/0P81
 hMVIoIAdLBsZO0VwmPrpH/1YTRMjHholnWqUb5fHwnaWIpK2vWGNWf/CrSgsmdKWdxFqGMHHWPL
 1ZqTf5JCBXXb+6xfg4LQdl07I2loTL6jVB6DMwFSRDXhu0ntLycT8xi4Q0NZlqBMJ9TBC+FJcPZ
 zHKyXn2zD48i8oZMzFdhMU19Crj+Kb4D8Ea+yCfWCOxvs/YIxPgxMOz0MPl54rpj/jcm60Kua5P WbhzXjTYboExRrw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Martyn Welch <martyn@welchs.me.uk>
Cc: Manohar Vanga <manohar.vanga@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Soumya Negi <soumya.negi97@gmail.com>
Cc: Alexon Oliveira <alexondunkan@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index e9461a7a7ab8..a0acf2a295cd 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -165,7 +165,7 @@ int vme_check_window(struct vme_bridge *bridge, u32 aspace,
 {
 	int retval = 0;
 
-	if (vme_base + size < size)
+	if (add_would_overflow(size, vme_base))
 		return -EINVAL;
 
 	switch (aspace) {
-- 
2.34.1

