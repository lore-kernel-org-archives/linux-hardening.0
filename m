Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85B34B437
	for <linux-hardening@vger.kernel.org>; Sat,  5 Sep 2026 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636608; cv=none; b=t6HTc1Gb46ZBMcA19BDNytUzUvUdxbIDa5JXQf8UR1sQ1U12XtBn+bRhECok0jBv8WjT0G5khKlFDqVSkxt0dMfy7x3b2JXOXImw00ZtuUAFw486Au9sRCAC82nMSEPw1We66sESD1eNjktRRrK3CV1WvTxnYEKWUySimER4TtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636608; c=relaxed/simple;
	bh=VZR14MCxNh2A4lpCu2ULzsdkJLn38YcLi5GjcKu3bfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aoTqD4s3/lr1jUxnhOHpuAe9oZ4N7csPXrCbZGBdz31t9pDkOHRNuTBgSLqJanvZL+s0rhB8+vKzd4HEzNYGoQfl3zNnushvygTegDnZVSRRFnvyYREn5QN3tCXtQnJQ0M0ywPzcnsanwRJa4VnC+GiQPYVzUZ4R4qkFMsEKgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JM/qbGKV; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM/qbGKV"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-836c4474028so22487347b3.0
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636605; x=1789241405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9vF0M7iPFxLRTpzLYkvQl+R7kmZssLscv9SjnZJvbD8=;
        b=JM/qbGKVFwlIBDX4SsLKkZ5DIyVmzEOq4U6llmSrdh2Pn11JHNCg2ufDztkTtF6cwO
         qWm3lh6uf+uHwcIHKI0dRXswJtNCHCecb4S770BDtWIq32TPogEOxKBOj1ThsEsBuy39
         HPiOtJZ8g6/ko3tATxQ2vA6CZvgq86iJ0EJvvX/g3wm8MjCOFHaeIsh0MN0nylzUgQIH
         qYlFn73IepRLFkCfK90bKcVKMH2ZLClNraaEPV/lOtZ6apXlRoW1hCs3mmNBfy5vazah
         N4DXXHw1PznnXzQW1jrV/65kCkTEiMNyWGY/X75U9JfI0AQF15UMzYPHrtjeCwY0WbPi
         vjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636605; x=1789241405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9vF0M7iPFxLRTpzLYkvQl+R7kmZssLscv9SjnZJvbD8=;
        b=M3CTyBv9Ob5zTfoAnJd+WaQG45fM06BTy5Z2m00oJL/Bu0b09oGzjhLVKHlNXxwY33
         BTiqhTmYQtMQ0SLxxGOg62Q3Zxq7gzAvtwcPfW6QkH8t4L2K656lk3wVOkMMJbs9ihjz
         nszdDuoS8KVuqa3nwrDDZJg0QyglfmM7TO+HXFOUjpAcDkmopUW3S4bewR56Gz9bz9N2
         oT7Zs/eYxmdDxYqObqaMIp5uu13Is6TWtjwnhmK/NTQMcV3J8uJvTXf1tZs2vByI6sew
         5CgEd33vo4NQUiYH+pFEbbage4JEAFN/Y97P9EVBcxbCHzXsH2GR+54USWUQvCsQVsL2
         aiyA==
X-Forwarded-Encrypted: i=1; AKwUvBw7DK7x9Ckjr9Tzcd6oHEUBJIyzpPhO/vNHycNRD5pOSUJWwkblPulV5A2wxhsDQlZTw9SlyoSuN+4DQckwVZU=@vger.kernel.org
X-Gm-Message-State: AFuF++mB2fjgwpy4oO+VhtZ9q3dfthj09I9Mt3pna0dIvqA8trixgRpI
	fONXy0z2kGcmnJaosf4QRqNlyGZDTCNLv4Ake8FNQKOv5EPsNYff4y4c
X-Gm-Gg: AYBFou2MuKk/CR+6reVjvHKmgX+Gr0qPQTnKhjWFkt7AMSIWLz3mXw263zC3dgk0Y6G
	sYehSPgJ7lOZyOxFVnSDJz13k1813DrLBsxyVR5n04GdHVM4p+92UKV7zmAU0q+Vo0wxqnzKLl7
	V0ugTlQRgMVqDdupy3a5CWLCdXEEImuRlSsBroKoT/1VdwHTiFY9LiDnt0fQv44YV7tqx3I6SRP
	nIZfP8e8hB0d8IoRp/mLTe8LoaeJ4Uw1j20bP0O0XE509VNYVN4LD4aRzvy/BLbc2ui1HOtFxkh
	Vbt86+m2NfSLo87i9ct1bd77bk0qfYmf42TUkjo/ym+YMSJi7esNEpZRzkZdCYW9vxNupmhvH0v
	nAPQoVeyzQzAJ3rmmIspjpsJ5Ikin2Apb3CuYJDIG33cVHSWqcWcKWMnPB0PgJfWEqQOmlGWLp7
	NgKXXwNRb+V43CFrEYHP369fivll0dN8HUYW9INESZvizH0kYk8K6v644s+PxyQ2LwNlr8K3Q=
X-Received: by 2002:a05:690c:6b01:b0:81e:45a6:bd53 with SMTP id 00721157ae682-87123239b60mr53834857b3.8.1788636605315;
        Sat, 05 Sep 2026 12:30:05 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714a0b6179sm42966377b3.23.2026.09.05.12.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:30:04 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 05 Sep 2026 15:29:39 -0400
Subject: [PATCH v2 18/22] alpha: discard .eh_frame and the relocation
 sections
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-arch-kconfig-options-v2-v2-18-83e8245761a2@gmail.com>
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Kees Cook <kees@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=VZR14MCxNh2A4lpCu2ULzsdkJLn38YcLi5GjcKu3bfU=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm5E553Odw4NJkVYVMma9Km7O/mC25rGjIfixN3PXHg
 0XRhfVWHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNDhlGht5FVzXXsH
 NM5X91LvRj3PL5c+evD8guYPjqYHL7Y/KxXbsZ/kdMN2aZ355hbS7Y2H7xeG3ukVf5ZQ+/5X18w
 f3BiEnIlhUA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

gcc emits .eh_frame for Alpha even though the kernel builds with
-fno-asynchronous-unwind-tables, and nothing in the kernel consumes it:
the stack trace code scans the stack for text addresses rather than
unwinding DWARF.  It was allocated in the loaded image, so dropping it
shrinks vmlinux by about 1.1MB for a Marvel SMP configuration.

The .rela* sections are equally useless, as the kernel image is not
relocatable.  The linker was already dropping their contents.

Both were being placed as orphan sections, which is what drew attention
to them.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/vmlinux.lds.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index 95704e64b6a6..c44941d3b874 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -76,5 +76,16 @@ SECTIONS
 	MODINFO
 	ELF_DETAILS
 
+	/*
+	 * gcc emits .eh_frame for Alpha even with
+	 * -fno-asynchronous-unwind-tables, and the kernel has no DWARF
+	 * unwinder to consume it.  The relocation sections are likewise
+	 * useless as the kernel image is not relocatable.
+	 */
+	/DISCARD/ : {
+		*(.eh_frame)
+		*(.rela .rela*)
+	}
+
 	DISCARDS
 }

-- 
2.54.0

