Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807074BED
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249733; cv=none; b=NmOUiP/fpfuwNbTYNcLAcw34xKh8+H8iv98W2YnhuKQQnKatKPswjI+6CrylG8nOT7LNrU0rjKD+yze+MHEJc9SvGtPpI1FHL312YLuRzZMN2oXWfQQumeFAVpvDZ11SSmryIaiP7etOeLR9z6aOd+C4UMFB/5zlf7mzZWVTrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249733; c=relaxed/simple;
	bh=af0i+Z+NBmK8wTAcFrJRYhmqFQ66AAdLmiOFLw1OeN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=axZaQieFAjKlu+R1N86sehmECXB8cDXuuuEgR6eG8OQpOo9jeaFiWR0aFC3njjqyHmxvQMPGk0jnTixw0tjz4ZBTlsOuKTvg0J1ufzluhwG1Cb45uNoMMiAEswS9WUN7CU/g8+4YsrR0qW54UpOePMYEX1bI4NKSQNUTjQGj3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iV33OeB/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iV33OeB/"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce942efda5so1215730a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 15:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709249730; x=1709854530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgeC0dWQiXHpXbv+RTu39Eq188gL97uOmLAZY2hF3fA=;
        b=iV33OeB/heUvveeMxMcuzWULjLQOcnaBkonkrwllHoMHT9+q6G7sgVqjqs9iqspm12
         QqLO0jSpm/i2UNS+HjnS2KXgqhnLKSQP6OcHQpFiHakAVrmhl1N58ojk/wt3yspqp0Ff
         yc5+F5x++hWxSdiy8QHHczoGzyQwaSj8VBM50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249730; x=1709854530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgeC0dWQiXHpXbv+RTu39Eq188gL97uOmLAZY2hF3fA=;
        b=cAIypQoa7xEtN80Y+ZLnPV3dBL+g+vRtX+AErfb6kCgQjGo+wojva913b7aVcrGC9d
         GtlkrBIltwy0oU34WE7dP4X2ccToup5HQfdZlPkFRebrajjHTXBHWhD2upU2MXb4dv49
         /O7seMNVJ6R8vpSPxs2jHyYHWTCvDjH21GhtxkVTSTr7EDOl4lslgrJWvdHE+7scLgIB
         zvIvER3uVezrv8MHq0C0h6eURl0zhzoZahwQQBu1t6cidwCrHIQnRxkoo7ILZ9PoBVu5
         WBbgqxQYbza/XZhxUibfxfGy8P6NKA7UDTajwIJwzeWQpPf9Z4etuwC7OmdOXBz9VgRe
         IxQA==
X-Forwarded-Encrypted: i=1; AJvYcCUKnc5QdjfFeH5guoYRb6k+0EzIdtoD1iNv0aj/D+3CD06zphUDvi3J673Gg67XOrP9k11e4hlwuHTbBZ0xIJIVz/i43K7eUJsyUb16n1fM
X-Gm-Message-State: AOJu0YxxGKgSMGTEe3bgQZMXFOlC9QnazKDBH1PVQ20ZyO92E2ym/Sfh
	dFIG+pjB2zRpj/3WgrkuN71rUgDVA+M86IeH/Y2dlZELC7q+8fzPOg0NouZPEV2Faa42WATcDkM
	=
X-Google-Smtp-Source: AGHT+IHdzgU8MOGA5OKgWWi/ALEW2RCneug+tnxz+xSDAC8KU+oM+pEJdlK0nR/tNDGF6pdVEe5zug==
X-Received: by 2002:a17:90a:9481:b0:29b:1964:3921 with SMTP id s1-20020a17090a948100b0029b19643921mr82708pjo.46.1709249730678;
        Thu, 29 Feb 2024 15:35:30 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x24-20020a17090a531800b00298975077d0sm4146974pjh.19.2024.02.29.15.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:35:29 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] string: Convert selftests to KUnit
Date: Thu, 29 Feb 2024 15:35:22 -0800
Message-Id: <20240229233432.work.675-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=704; i=keescook@chromium.org;
 h=from:subject:message-id; bh=af0i+Z+NBmK8wTAcFrJRYhmqFQ66AAdLmiOFLw1OeN4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4RS8DgHghW1lD3n4SWnltPLnr7H9SGtGAp+Br
 8H0kDAa54GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeEUvAAKCRCJcvTf3G3A
 Jn8kD/9JnIyBUTtwBNswGjX9Dv3u9HUZt9zvuY9Dmpb+fBXd/VSq9KauLA7vo2CrSnruGsZ9GYG
 o6/DQynkvUK2WSzaV/wcqovVciPJ+OZ9MuZ8N4Lj8dVsASz4wxNnU0rsCfg/A9q7q7ph3BUiV52
 Y7V6udqf9+2ezuI/1mq5wdv3HrEvfqogMbwx3LPW+ZJRaBBqTAg7dqVRxU6eavWPzHxX67uVbg/
 y/jfS89N4d8hanXtonuifHw0nFudU4SNW+C14EKC1UuqHxwQ2qR4iiXc0Mw1lPYmZrPoD2hG9DJ
 BG5Lw0AbVECzEk/je4GwaWQ/sBSh+ZfEaxx2xBD0ISJgyLmIlm60FL8BKtYAtjUFmqoMGeiXWGm
 qMlK+Y6SNHSPS37CJ/wrUz+OaSdEOZbV7dbrE7cP3T6HveouT5b2xj+Lb2weInPKQgjVXONukfU
 vI+xy+JgEArv/fcZGM4hRqx5vzdH8bZoXMWBLxw12SjE/nKA4VHHRU7DUs5/vL8F5FVebF2iuJx
 mAt5wfqbtoQeqELn+3BopODrgR5C/EhR3lKpe1K40kfQqaiogSXW9A5RBxHUAVkdl2LLYj5fi9a
 57JjcO+5QckYCYZ8xE7U/EuOl+RJj81uG4BCU1EQeSPWHQ1Vbkn3q8C45GVe82YlTERf83zKmk9
 pjpt1zYC ratD4aA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

I realized the string selftests hadn't been converted to KUnit yet. Do that.

-Kees

Kees Cook (2):
  string: Convert selftest to KUnit
  string: Convert helpers selftest to KUnit

 MAINTAINERS                                   |   4 +-
 lib/Kconfig.debug                             |  12 +-
 lib/Makefile                                  |   4 +-
 ...tring_helpers.c => string_helpers_kunit.c} | 160 +++++++++--------
 lib/{test_string.c => string_kunit.c}         | 166 ++++++------------
 5 files changed, 154 insertions(+), 192 deletions(-)
 rename lib/{test-string_helpers.c => string_helpers_kunit.c} (79%)
 rename lib/{test_string.c => string_kunit.c} (54%)

-- 
2.34.1

