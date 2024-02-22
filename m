Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44AA12D21B
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639258; cv=none; b=gByA00C2OLtKNUUl4AXXWbMPIvp/bWBmy6f9ROHR8TofHoSGpjeTFjuS25IGt/6SAfl1GiNv33C1P8QEk90fSHc8U1nXJxaTQJnTV4TI+Ea7SLzhvSFrtYBwz6CtEdCxSNtC5MeeULaq3hrwBmrgc9ZeerlGzCjBi7wkwsngyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639258; c=relaxed/simple;
	bh=/0jZgqFV3QHFwXdwQjyOlzwZPiSes7vDjViaGzmwhVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHbtuTniiE4v+Lxd7jKghpLdRM+AdpyRWU5XWGUuM9TXPzeocRWJy69KDoy+pUjCit3/covmT1aKhbvG77FvuJNGUB5PA/mqDoOPpPN6M9+pI8BeBY1Cu85xx5/X5+euJxAGvRIUQ1G9GfSs2e+H65KkOekAkzSQuXCNdOMLrfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XQlrXfAN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQlrXfAN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so2833365ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 14:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708639255; x=1709244055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7U2tjc40/BAOXSRwNIhZS6QrofSS9z/mAZ0ltWiA80=;
        b=XQlrXfANKAFX/0R+ZH81Am2eORBegGANg5R5hlUcFpf02tdb51GlueMksGS7WQ/0au
         yZGLlxYczA/be0Ly0T0hiO/uRUzhaty0KEeXTwxwf820+EMccDPev4ZuDYBoFKiwOmS5
         ntdwRZ8AxjsYoz2HpNdGzEkFseseMQ/ZpKuq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639255; x=1709244055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7U2tjc40/BAOXSRwNIhZS6QrofSS9z/mAZ0ltWiA80=;
        b=eTMJYxCm37sxVnkflfK5435b9NX1jK0Eq7NrzvZqxiiAYloehEoLdICGY7QjtZtAPQ
         jbGW43Y8wTqdH2NG5lSnLYJ45bsm70F2zAhahOa4250DgXOTy2btwhr1CQn+qx5YbQ2K
         86MPYW/maAo+OQFHP1jjvAOXfGXlMOLQ1vEca0aQdpbHWigR+lFaut2grm2LBsMlopUV
         ARuW2TAaNcnhEu6RLBMnMH5pd44jlBkPo9x8ztiD7ghn1hp0uu3nOj7zv8aZWbbWDrpl
         X47Iig2e/gtug07muHrDb7A6iHEvgDawuPRX0begl+VGf5qIT7fkEmbuwdtBG+oYC10i
         VfcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtatrBsg9w8dEoLQ6IxPGDEcgStK5VVviO5ms8RSSwlTOpqew563D3eiEuqAH3ty96uG51YZJ7T415eNlojic0Rye92F607HRwRfFYp+cU
X-Gm-Message-State: AOJu0Yz8vMzZZ37pSinPiihrXquckAz3hyXru6Go07y0tVOCUe2eDAqq
	sh2e1ACuyrer3Xkwm9Fcp8NfJWydR7xTN6ECyHuQvc1eeVUhbE85Z771g2wTdA==
X-Google-Smtp-Source: AGHT+IFthqR+g2dBw/UAHrs4z25heuFjZDGEvpiSvMlZdt+AxyMd9KMXGew95W1Id88zqK02C5oX0g==
X-Received: by 2002:a17:903:2291:b0:1db:fd4e:329f with SMTP id b17-20020a170903229100b001dbfd4e329fmr158789plh.15.1708639254752;
        Thu, 22 Feb 2024 14:00:54 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001d717e644e2sm10357386plc.247.2024.02.22.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:00:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Kees Cook <keescook@chromium.org>,
	"Tobin C . Harding" <me@tobin.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/4] MAINTAINERS: Update LEAKING_ADDRESSES details
Date: Thu, 22 Feb 2024 14:00:48 -0800
Message-Id: <20240222220053.1475824-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222215755.it.764-kees@kernel.org>
References: <20240222215755.it.764-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=keescook@chromium.org; h=from:subject; bh=/0jZgqFV3QHFwXdwQjyOlzwZPiSes7vDjViaGzmwhVo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl18QSYDlmaz4o8wEpSBDere7LZ8YHox0i+LD6P fFT/CbFwrGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdfEEgAKCRCJcvTf3G3A Ju6MEACz0ztHen9/0jUIZ4S7P1C/KaEPNBQFSTxxU4ebUBIeSf9lR+aMLQgkRqYPHkNhKUwMyAe 0kfKRj+c2d3kl6WLlwolO6hDU8L2KJgSTIH9YUvw6C4dZm9qjGPBbP+nS+KNwjmZaP7mbr5olEz OeZlrWDukYeZGGfH0Z8HnfKZy90SSYZFpr/NN4278Hf23OnzxJcQhdIhzHkpOhyNzvB/NwSTf2w FeufXgd72gxmzIL9Ezf3sxn5HL0FbSNqrgoJ20bXnawW/jKSSZGQTCtOkm/raGNNycdBYLxG5eb 03FGXYdPXmw6KgOkEnilYPbjPRlKODOP5kSfmcHZycfRGD5sXzauQ1leB5cVRfzZINZdBMixOVz G2XO5A1+2WUxc3lP4vr/WynIHOpXwAww7lWeRQMQ7iBuxCLp3A1QDoOoR6j0bB1OHQw+VEUJ3fX QFXW5jWdlTX8hxYc/gs7munqdYDOguFquGU/Xn05okUzK4XheQ4CjO8LbMD8np9L54W7LPOEI45 o0EkGDwQwdazQn8HJPJ6rsGhnV/rY2TRIykGjLSA30uVhsEFRhXaF6vD5TDGBTMWZT57Cm7F2kl eH3d0gUmCcTu99DiFdfztZH1+hODUAEbwhtmk7EZsV/sKv8N+suvdM1C6vwnkLq6xAuJcclwBJ4 Sb5oeiSWhU8Z5sg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Tobin hasn't been involved lately, and I can step up to be a reviewer
with Tycho. I'll carry changes via the hardening tree.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Tobin C. Harding <me@tobin.cc>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 216d02a3fed5..cd651c4df019 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12154,11 +12154,11 @@ F:	Documentation/scsi/53c700.rst
 F:	drivers/scsi/53c700*
 
 LEAKING_ADDRESSES
-M:	Tobin C. Harding <me@tobin.cc>
 M:	Tycho Andersen <tycho@tycho.pizza>
+R:	Kees Cook <keescook@chromium.org>
 L:	linux-hardening@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	scripts/leaking_addresses.pl
 
 LED SUBSYSTEM
-- 
2.34.1

