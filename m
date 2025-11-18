Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496A3314D3
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460267; cv=none; b=l8it0c0n0sSVlzTvqoYeHQVH4wEWwKm4qhnAyuLNCjvktbiVYcyGT54ivVKslEKuMjFUNCxrcEiN43h2ZZGFoYmw9jkVvWxG8rPf5vxWpup6kJ6lBklf2rs8U9lDVI8f1CcIgCgs9JiGG8Gy+jxPdTI50A+mfkgIxRqUsUcqsBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460267; c=relaxed/simple;
	bh=4r/SeoaCCIAi3JIULQdnjcmc9CqF8XFZH5sts6b00Vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGtUyDIfzIcWvXmmos0/jZl23wsJt14cX3pMa/6bakVZjtjIOQkFbFz1UzojxE6kYFCMW9Ejgkbc4TJFmS39NI5Z4dBcYMJJ74waNdRbRpRIseIWFLT1HahnAqMYba+2K7Rzja3/c73Je34zbpBYlPGLmdYQhWliDLUbJR9DQ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pXFB5ilV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pXFB5ilV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3c965df5so3115252f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 02:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763460264; x=1764065064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vq+Pft6402NloB6lH7I/UzA1MCeP7+OKx6S/AOvrUHk=;
        b=pXFB5ilVwfJ+ASpPa9rDL4YHzBz/ohRYcKwuFdgJyMTHJWhavQCh4ejLfh2B8D5fT/
         Y6BSmmXXYFW7WZt/2s6jBq+RaZoIjzUe/Bvtilnr/gcnMgaZL5f60P/bKJ4KHtv7TV7O
         ifDce2rqqUuoxIhRenX2KWlU4APpH6+KPktDISF6iDy8lrbE17zCIZbGraO75hSdMbOy
         XZkgvymXi7xr83KQxkhq/vi3ctKIEtENLvQW/LGzoCryFzadANZP3af55AQ6jSkyZOAa
         re9p7lEH73b55dPuPD5Qjt1qnoWZ1YcSs0p3dcUXq4BotDH1PHJ+xcIvJWRgTGdmbBmM
         euYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460264; x=1764065064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vq+Pft6402NloB6lH7I/UzA1MCeP7+OKx6S/AOvrUHk=;
        b=B9AYvcGjbgAa5o5BCulrCaTymH30ZrkcUs0LyYbJtSjNBoVq4nRtdxOoe4urgm+DUo
         V4YJOALCcIkwwzrZcvY/hvOUP5VpNwzSjjA+h5njbpFAKv6aTuQPm9bnbUIZKa3joKe5
         JgaIVbvPukD1j7zIZcKIEkKaYCjD7/m8rJe7leSN9S0QVUGTe74LvWsGGOY9+E6wd1lo
         aGCnB0RujyErypJCZeVoNBht1FUtPeHdZ7D3XIrc8vnmkX1XiBPwspOe8I0fksXb5Mm1
         lKu5//zWmltS9ryNOX02ejrmFlBNUI8H7c9lFstUbBxRHOG0CY56X06PWKLXtw13X3Fi
         1qJg==
X-Gm-Message-State: AOJu0Yy2aponU/sDoTAXm+wgZaBaM48F2VZXDY1fX+Kf8viUQgwQ+qgL
	YhO0s5p6a56Y3S9kwQsdwcWIssCHSbEobm2LCj/u5wcoq2V1LVpP7bBgyu2ou06C3rA=
X-Gm-Gg: ASbGncvrgdZUY98RB3Lhbx8+Dd3g+JPo0uSHKVgV+R2vileLO0dXTGzxOcBfBZToG4r
	NE1J2UIgApUqRz89i/ajzlOSI4E2Kj+6VXdnVxmvBciyh//IaQnPs59cniSiUgpze1Zy/w8m5se
	WO65jnDGVIsAGnZhcb7Lc8WyWDgDiH24p6RBXDlEMbNIIRG/SQmL5vS3pZoDD2JQrav0oyU+1dm
	L/2kIfA9HUY8PmqvfYjtMfsA5HInogl1AuHSwbFMgU2+Dq8FT26u1ZtOw4uGw6H6OSfCPXtAnFA
	wZ0WMeUm5aJajMKmMvT5b+Lyiy1z7b+6ZbGOcDoc4yNzhlb8u/2zNtg0jYHW0RtZNvKvb0tlG9r
	9GUp5TndHArrdo63GQpmyjMAjjEY78EqHqzGqCjsGQkjcun6HsWb62OrClnFyDMiZhXVmBqUqs/
	8kLctsQjzuTkO2+A==
X-Google-Smtp-Source: AGHT+IEJsA70dq34ldti0Tx9GYflk+VhhZATrbEzqdEK1Hf4VJp35nu/NHn+Ba9k36nQF/Fxdj+jqw==
X-Received: by 2002:a05:6000:40e0:b0:42b:39d0:63a4 with SMTP id ffacd0b85a97d-42b5938ad8bmr15157322f8f.29.1763460263819;
        Tue, 18 Nov 2025 02:04:23 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c283:3472:316:988d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7aea7sm30999781f8f.1.2025.11.18.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:04:22 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 18 Nov 2025 11:04:03 +0100
Subject: [PATCH 1/2] string: fix kerneldoc formatting in strends()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-strends-follow-up-v1-1-d3f8ef750f59@linaro.org>
References: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
In-Reply-To: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=rFPRaj8noCZUimTcsPf1nVd9JEAQZsTXpBmPCdLeaQQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHESkXfh+DXO8ryd7E3htoaJJ5aK+UaKBqB9Iu
 WoHziP1dcSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaRxEpAAKCRAFnS7L/zaE
 wzCgD/wI98gzMhjAbmynBwZ8gFTPAMrmMe3OOY9/+tqPQ+mpw/ufNWn7OqnRMj4rYTPWB1R2TSO
 94rm08HPSIm53MgKf4+9mkF+LSIWyaadiA36lkZpYcqTDGB1v2W4hyhLRSHvEh8OppE8KLJ7E1Q
 o4yOjRfvm3xlZ6YrMZDXOiGKdjEo1k1gobRiAdk4SuLb5iK5gcje/+4tw5IEaP9axPTGYkil+/Y
 V7x0EUCr/s4BfF4ZX5+KjUItVwklWtU/JGzz0QIiTLOIQR8xETtDH7XVGdk8AfiqyPVGjhckav+
 38GqVqpj9sQwSRHrV1GEqpXyYI6F7vmQmwYyqoM6awelL4Zr8g7YE14QKf2KY8teGebokoikTBe
 2Z+wVQov/RjBVHmjEsHBCz6ONzMpWY6sGC63oNXaZRslP3sDk9cf86mzvnRUC5HY2MlYjC1XJDp
 kKHgNFBKlHPv1oiiSxKBHb8dRC8VgXpELKpU1ayj6b6cKdIpFJYbTk00OTR8BdGsq+5IN+GcyvE
 oyDTNIjoUeU7Mj6nhJPApUyQoDac13GlG3lpwNI5+W/JLZRPnd48RXKhg4S0+/GBPPnsOWFj5/j
 1ahvTRni3d4mMfrvnWYAvmsr4lpX3rGG5GzC4kdnCXgcUFRmzaSFZyAGucHCyGtdH4pGhfYyvvr
 nkwUfC5xlQUOoUw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

strends() kernel doc should have used `@str:` format for arguments
instead of `@str -`.

Fixes: 197b3f3c70d6 ("string: provide strends()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20251118134748.40f03b9c@canb.auug.org.au/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/string.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 929d05d1247c76eb9011fe34250b487834b2d3c9..69e9256592f87e446d6f0be5034056aa7d0b78b0 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -564,8 +564,8 @@ static inline bool strstarts(const char *str, const char *prefix)
 
 /**
  * strends - Check if a string ends with another string.
- * @str - NULL-terminated string to check against @suffix
- * @suffix - NULL-terminated string defining the suffix to look for in @str
+ * @str: NULL-terminated string to check against @suffix
+ * @suffix: NULL-terminated string defining the suffix to look for in @str
  *
  * Returns:
  * True if @str ends with @suffix. False in all other cases.

-- 
2.51.0

