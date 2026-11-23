Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443382;
	b=rd9soV4IhXvnjnVYQz3jR3DKbCtUB4tWsopoIMkrKCx04ufBv5tNmOAepDipSZm++qWF
	 K66qnHTem+bVuQp5lVw028e+mf8gQbqz+KCmPiJNlt+UggMuN4NTq1zh0COpuE7dx+Aif
	 /sqj3ukGzCXmRDsh9AYp6UX2BjB6X7CmosjdHbKZjNOjpfQ6sCtMipAa9BQgDZdVAZFq6
	 MyL2M0G5UPYb7f176uE9eBF7SG3WJrpXhWx1HVGxOMy27Dji/GyHPq9qE7ZwWGQmFCRDo
	 xMQXpaC/zRHw/c15ZZudZTv3RpG0cF0R6YajWPtkmIPSxCVbAGO1+QY/mWOpiEPpeHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6ieYUzrkSoXKds2DyD8v4HVQRsA87EwueP4G/any/Mw=;
	b=X/+BsBujn/8s3zTVC4WqfkJCUIw8Xqog3ouyKs6tX8EscNlNw9CDa/5ICuz/JHNFmDof
	 umdhTEsaPHDJy6Opnsn/wVm0ipT4rCWjVIZ0rBCNgB0KoacWMhIkURif0/6/I2NBlEIH3
	 u+poKbemwbdZOfv5PAuE0L4eW+GSeCDf+vh2Grdv9Q1Q5Ata+ag9WdJeX9jthhgDALaR2
	 OoY7Gt8NAEjmBPDXOnCXE/KHOADlBt0bB1iMfrkRAgIYQ6CJ+b9GwqE3KqMx0fUpGAVWm
	 /5NM77uTALC8xhETGCobd38Pz5UIRITq3epG5BgaPnh/VBsCBwwFtOR67Sr9QyogUeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sLD3hqjd;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD46606A31E
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BD46606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sLD3hqjd
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-385d8a00598so4601118eec.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443381; x=1796048181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ieYUzrkSoXKds2DyD8v4HVQRsA87EwueP4G/any/Mw=;
        b=sLD3hqjdh/M6/4CCDwHIErqc62yPh4AQ+IWjEASoSX59trn3LMf0OHqbf9v2mF22gC
         vwJLk3k33RD4TI/jBIuok1+RqPoWXnS+wQQLfNOwvgMH1ALc6Yvpa9GUMVviW81BosOf
         EiWgcy3uMMD2yEeNR4lcT3Oh9T71OltXpp+PxeWXyjfZubz22a5zkc6Gqm/bZUj9Klsl
         8YSEGjF+P/cVOm1gxW2h+/r4rjqj3e8B2+TpDQ4zicRY8zE0RV+zege0PpzF9ym8OOdW
         0RFdi3v5eczg62x8McWgQLa8nx0m7ZYD04cZETpoPaOPDYySHMYdNyagUkqaJEVtoKA0
         vdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443381; x=1796048181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ieYUzrkSoXKds2DyD8v4HVQRsA87EwueP4G/any/Mw=;
        b=0WbHNjq4QoLlBHQs54S2WtPtEoMjzR5QbIR6lQIVJ2j3uHte9JgfUNyDjYSqHD/7tn
         mUmR1pBWngWXSNNqy3bFa626ywro/XqG3Wo59cdEg+SOExvRMR6bBSa+xeOFzcebYGxY
         cww4hMkua61ljRJxzlyfeKqu5CxhAObAupmYf+FQiTEvnRD9AOWpRISByPUSE5dVubOP
         uP+qQFopX9iUOd7vjux6GzDEnwvrbwq1a90WH0ClBVPaPKez5C9H0AYLrZjpALINjB7l
         DPUc4tSpy+n8zjhGLYdqCklPDKaSNyNbSqqraukDW+1PkJ2tr0sJhJxj3QKSvj82aL3g
         3BuQ==
X-Forwarded-Encrypted: i=1; AL+hErH9vocoD/m0PaeoJsFw3ywkfLAO0nMiTc6P4pMeQPu2TP/SgpEiWMeY7IhTZT8GpSYhIXpwnMTwf3W22R7lYtE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ur/Wb5ZNep4lgHNgWCQkfsOTx9lmt5VXQs/6RHOZlc5jGtMgB
	Bixu5pA0vUd3wlgvuAYFta+xe68aUxwDVHCNWbf6sgU1DxbmYbVC9BvE
X-Gm-Gg: AZFdTZfWG6v6bu9UpGf7xo9Plg9qx0DudFyU/EDt+AaXhZrCWRbCQS6NPwsPESDw0Xf
	uiS2GwS77+mvjGk/dKDqGAgY68EfxhcRot6iRITkr3YFDkJq7EWWijO77a6AXxwBfju4jk1fNTe
	m7t3P3oM26iMLmXLYmKhd3WS8gOWr7zDFWfrapOMmEjpMVvhTYhG8C41Bj5Ig1K4/p04c2bO9hx
	dkzvto53d2z/GvPG16R+0klqvDBpqFQfc1V7shrrD/1Nsb0iLx4Q+m1Q/KsIglUzOEBgDNYIBWy
	Qc9ZqD3mBa/rGxqnuM3PAGIyDA7WgMQJZx2aFKVs/a6nmSqjEWGjv97E7Fvqwg1oP4kBXkC9z7b
	QD8USdSmDEKRD0HJ3L+r5VuG+vCK6MyIMfyUt5ko9oG53msViyIVD7frFmv7bo/5W85eWWWGzu8
	SHUmexf2V6iy61IoTqvohR9qrcVKkq0n0P7OIW+EVzFFcCR+WSxNdRScygKjJicXzJkMFZn6zcd
	VouV4iY3ypsb/glamxB4g48C8xY1tQANFgw7R5PMCO//kJFcWE9znSD1d7sgeJU48p8IPjLp/qO
	TZmiJ1pyBm0dj5azqAamWSotOst20viGBK/fbbwsA+jvegoJVqwSGawc8NP6s6roKcUN
X-Received: by 2002:a05:7300:8282:b0:385:af7b:d788 with SMTP id 5a478bee46e88-385af7bda3emr10635445eec.2.1795443381369;
        Mon, 23 Nov 2026 06:16:21 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm38349861eec.28.2026.11.23.06.16.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:16:21 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 02/19] mm/swap: clean up hibernation error handling
Date: Mon, 23 Nov 2026 22:16:12 +0800
Message-ID: <3e8d55101602d5ec982ae636eaf5eb4dcaad3ba8.1795439990.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795439990.git.lianux.mm@gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Restructure the error paths in pin_hibernation_swap_type() using a
goto out pattern to avoid repeated spin_unlock() calls and simplify
the return flow.  Also simplify unpin_hibernation_swap_type() by
making the si NULL check inline, and clean up find_first_swap() to
avoid an early return inside the loop.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c06f9f532e74..0ae901296731 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2331,21 +2331,18 @@ static int __find_hibernation_swap_type(dev_t device, sector_t offset)
  */
 int pin_hibernation_swap_type(dev_t device, sector_t offset)
 {
-	int type;
+	int ret;
 	struct swap_info_struct *si;
 
 	spin_lock(&swap_lock);
+	ret = __find_hibernation_swap_type(device, offset);
+	if (ret < 0)
+		goto out;
 
-	type = __find_hibernation_swap_type(device, offset);
-	if (type < 0) {
-		spin_unlock(&swap_lock);
-		return type;
-	}
-
-	si = swap_type_to_info(type);
+	si = swap_type_to_info(ret);
 	if (WARN_ON_ONCE(!si)) {
-		spin_unlock(&swap_lock);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	/*
@@ -2354,14 +2351,15 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
 	 * the same session.
 	 */
 	if (WARN_ON_ONCE(si->flags & SWP_HIBERNATION)) {
-		spin_unlock(&swap_lock);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 
 	si->flags |= SWP_HIBERNATION;
 
+out:
 	spin_unlock(&swap_lock);
-	return type;
+	return ret;
 }
 
 /**
@@ -2441,11 +2439,8 @@ void unpin_hibernation_swap_type(int type)
 
 	spin_lock(&swap_lock);
 	si = swap_type_to_info(type);
-	if (!si) {
-		spin_unlock(&swap_lock);
-		return;
-	}
-	si->flags &= ~SWP_HIBERNATION;
+	if (si)
+		si->flags &= ~SWP_HIBERNATION;
 	spin_unlock(&swap_lock);
 }
 
@@ -2480,7 +2475,7 @@ int find_hibernation_swap_type(dev_t device, sector_t offset)
 
 int find_first_swap(dev_t *device)
 {
-	int type;
+	int type, ret = -ENODEV;
 
 	spin_lock(&swap_lock);
 	for (type = 0; type < nr_swapfiles; type++) {
@@ -2489,11 +2484,11 @@ int find_first_swap(dev_t *device)
 		if (!(sis->flags & SWP_WRITEOK))
 			continue;
 		*device = sis->bdev->bd_dev;
-		spin_unlock(&swap_lock);
-		return type;
+		ret = type;
+		break;
 	}
 	spin_unlock(&swap_lock);
-	return -ENODEV;
+	return ret;
 }
 
 /*
