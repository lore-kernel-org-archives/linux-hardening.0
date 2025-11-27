Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D2329C78
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235383; cv=none; b=NWqZ3L3cAtgDkyIDDG5B+rsukFmhlwDnIc/0YH5UGN2xaH5APFQWUzu8lwVNcZr862QWFovP9eNei9cToxpYR4l3ePJIlFZ+/SQkpMkJj9maqYazi/U3JEGsdw2cWTyMrJpJU5KZgv9SGifj4LCKJuvBfPXX5bjQVwpQOF7cb2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235383; c=relaxed/simple;
	bh=kldLPMrabkFH+b+H9XhnBTB2n/8hF1gS8m0DCzqmMtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ebmx847xsvEBhGSUJXnoPfKB9FkWV3YFryTBWIM8cdvP70X9sn8Xm16Yf4jHcnbwcGzHObYsIMDCF2U0swWcZviuo5+VqiTL2qYhVBiNSJ1G0hQjg3+ntcvfcINPlx4bbIlb+cAv74t8QsicgrrLrMWWHj/2iF6vs08lqtewfDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZsWkVQf; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZsWkVQf"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47775585257so3819835e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 01:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764235378; x=1764840178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JB581+q6d8JNHOaG4/CmEZh7pybRjg32PuHi0tZmZIA=;
        b=AZsWkVQfb3HM5MwRffzi9JM6066sFJpmiENOFnZcTqI/K4bJtYzS7Gu5xCItNytTq6
         DCPNvQ+KSeKVJSRvHBijtxdHJRxkWuqUrin74LSFvuGtWhxXKoME6ZgptM1LuGfixBTF
         yg8o5U1hWaj4uAgRI3ExGDhFMNwuvoqPsryjX8mjsZ0p0HKZGf1xj3iSNCeI8GHfBe7N
         sTrf2snT0Ek82qQKNEfVBI0gyqCaI1CMrc5KtBHLyHDFhrADVosSszM4dU9TktouyuFC
         urbREQAaT+nQikRG0pzpEbxzl7zp90WH8uMcAMCrrE5037p+/HtkYqBt1RV9lcaD8628
         frbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235378; x=1764840178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JB581+q6d8JNHOaG4/CmEZh7pybRjg32PuHi0tZmZIA=;
        b=UVDab8E9ao8ObaHRp1g7MGrbhD9WRd1X/516c8r/LtfAJdVrNSU3Pyw4uCkkISmeJ4
         h7NeR5OEeg4kisSoV6THZeOPcP7zTQzOwidVycW4Gr3Pj+nw197W3eDywOCP6mz+JGAv
         rZvYySwSKRy9rOhQ73/VFlavdGCQkZFq5aiblTHpGrO89f+jE6JPMJGkui7b+/7uE7hs
         bIObPA2sTx9xNUCUNPFmPlE5NENW4hNeLBNfJMfmVlvs+mZCBAtEmxBVYk4sKnuBcqfL
         DzD6VPOq0TDnuno90xcRCcE+JDm+9jQIfN0Ny+LzP2trO79gF313Sdi86zfu726MasZG
         Df0w==
X-Gm-Message-State: AOJu0YwCWS+vKmOQacrjOY4MD+VMLm30nmnPWaOM/N9rquV96igBt/zp
	Evd4U5ke0RAZoyGeA4L043lObbn96KezqqsXhDBp63/hFXSsg2v3Zjkqfil1Q3O8DANqgvwXRyP
	YKWRyhDbl25q7oY00LgkpiVtwaDflcmNy/VeW5mkj4z7BGyPmvfkEFM3cddcMDttNVNI6uHswtT
	gQueXVxsmsJaDJNth3+b7qVTWlBv+yP+khGh+vSQ==
X-Google-Smtp-Source: AGHT+IFYv0kogWxmcupk5m1hglVZfqkLWIq7UCyp+YAuGkotWUr1R/Sn1oljNF0wCvZqVj/2EKsscbj3
X-Received: from wmcn10.prod.google.com ([2002:a05:600c:c0ca:b0:477:afa:d217])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5489:b0:477:b0b8:4dd0
 with SMTP id 5b1f17b1804b1-477c1119c31mr210109105e9.17.1764235378167; Thu, 27
 Nov 2025 01:22:58 -0800 (PST)
Date: Thu, 27 Nov 2025 10:22:32 +0100
In-Reply-To: <20251127092226.1439196-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=ardb@kernel.org;
 h=from:subject; bh=RU3u+df4cRqtBp/zfgIcQz76smq5xWuDnV7q7Ms5D20=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVNDIrr465FjPcfCXNcVfxHj4EvKbXd52VbuPb/gSv/TG
 XXn23d0lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImUFTH8j/4n/GKfxT4FdwFR
 3ZtT2XVftd3pMVD/b7vd89W/09tYChkZzgTY/PHoy9xc3v9lheV8neWin38fWBntofx47Zr7DX8 +MgIA
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251127092226.1439196-13-ardb+git@google.com>
Subject: [RFC/RFT PATCH 5/6] random: Plug race in preceding patch
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-hardening@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The lockless get_random_uXX() reads the next value from the linear
buffer and then overwrites it with a 0x0 value. This is racy, as the
code might be re-entered by an interrupt handler, and so the store might
redundantly wipe the location accessed by the interrupt context rather
than the interrupted context.

To plug this race, wipe the preceding location when reading the next
value from the linear buffer. Given that the position is always non-zero
outside of the critical section, this is guaranteed to be safe, and
ensures that the produced values are always wiped from the buffer.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/char/random.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 71bd74871540..e8ba460c5c9c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -547,6 +547,7 @@ type get_random_ ##type(void)							\
 	next = (u64)next_gen << 32;						\
 	if (likely(batch->position < ARRAY_SIZE(batch->entropy))) {		\
 		next |=	batch->position + 1; /* next-1 is bogus otherwise */	\
+		batch->entropy[batch->position - 1] = 0;			\
 		ret = batch->entropy[batch->position];				\
 	}									\
 	if (cmpxchg64_local(&batch->posgen, next, next - 1) != next - 1) {	\
-- 
2.52.0.107.ga0afd4fd5b-goog

