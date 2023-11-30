Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dJ9R1pwJ"
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA971711
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 12:51:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cddc148285so1396727b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701377482; x=1701982282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TfXrVytW8Y4xCjr3/gaeCHfvnpxnYpvkHqeDQcGVwOI=;
        b=dJ9R1pwJMTPVhzdrYhLbJ8W9lwde+dJ/qNBb5KcVjm6+EceGXJOIt2sE2+QzauhBHL
         TRW4jQ61YcLTBFINAKki+zpg0qWVYOKX6SwjITD9pKYVCNjTJv+HZJyApoxgWzpdRbGK
         RGFfglNHb4e9DgGKT/j+Bpz5p2awanneFpP7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377482; x=1701982282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfXrVytW8Y4xCjr3/gaeCHfvnpxnYpvkHqeDQcGVwOI=;
        b=mWDCcHw7SaqEBsohQ1EeO1INil0MpPYUHfM1dz4fZMstHfxnb5XW/hIc4UIpqvkgUr
         EBn9/xc+AAQdszFMUjsEzDTeKWJj3fEL4t/QKcmD0mTMp/AJTN9v4wTEag95dysRccCv
         5b/v2ujnnMEZ3AIcg/o6cwjFSyIg8fynAaDT1SExdH3LEXfWbfzmigVXdlYwwX+Qb/Y8
         cve0o6HPsu+3dcAfomMuo+AeFVV5v5zy8WmyuQjHpxNZjG8zwfNJBVKYZ0Iqfnn+wgNy
         3V7rs73rW5bsEbtfROfBketRLGlEdIkyWZPApvsiZ6tmVJtRFyP4djzlxgO3X8sLDcp1
         BR6g==
X-Gm-Message-State: AOJu0YxS6prIlsyw5nIIqwatXpZM8cMftM+FISHyFdJ95JzD2u6R0vTN
	OM1ps1H6OTSD+PF/vK5QEM7teg==
X-Google-Smtp-Source: AGHT+IFqQ2tMvaFz5HmonZHOZSdJGdUZgkkSvItnHyFbJfzglgm0Nzd641pdSg4DyaQY2ZQSUPU1Aw==
X-Received: by 2002:a05:6a00:8017:b0:6cd:e35f:997f with SMTP id eg23-20020a056a00801700b006cde35f997fmr4212615pfb.6.1701377481968;
        Thu, 30 Nov 2023 12:51:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h22-20020aa786d6000000b006cde4523767sm1644052pfo.22.2023.11.30.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:51:21 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Anders Larsen <al@alarsen.net>
Cc: Kees Cook <keescook@chromium.org>,
	Ronald Monthero <debug.penguin32@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] qnx4: Avoid confusing compiler about buffer lengths
Date: Thu, 30 Nov 2023 12:51:17 -0800
Message-Id: <20231130205010.it.412-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0qK/8Psz3/9NxX1Im3q4MPGhQi0CsgBgrOpGBgXV7zA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaPXHiFovd++oDnR0c7ouJGNE/dKwiifPcyLlf
 BxYEhZAN/CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWj1xwAKCRCJcvTf3G3A
 JpZqD/9ccxMmnau5U6ctKyloMELcYhn18hIIYhEld/95TcvsFCH8Xn1gWf4jnM6fBhzjbMHL7vM
 FdZMtQ1r7pJgY9xAOy6BUbX+ujkp89xA1lREEil7ioxgGsQIFhfQTCyBDgLxOiuM+ZTzDWe8jI9
 P7X3F1lxG0o53OU9wmVZKaPnXgAZS2DZaFrXUFOrHJmBMLcCt1MJFkYqY3p4xQ2AaUiStQZWVd+
 O1cLTqWf1BP1FKuPMkHk/ioYCEl9ZVHOCu+mzOVp6xZXSUErstM4qf9cKLT2Sw5dAlg1Pzt0WH7
 9+17k/UEqMfBfiM77PhiNXvGof8gv8/q+MG1jmWXiBSZo4+tUO2nL9STnwBfXCB1AE6FMYHcmEN
 ueCb92HCmY6Xa9k7CD5EBSZJvJQ6gwXD0Vgmr+Ono8U+TjQL/n9SFwv+T2xELITi9xvd4Luq0NT
 BiHXq+BQA5x0lP0epsz0rZVgdFhxmu6WIpf0bE2sHw273x6XsoAPhblPDuMmMsmjVKLe+OCgDbw
 foI51L8vJEfoh+HJxo7S1R61w3Lr94N7oU6iN9YU1PUsGMBl2jL6xpxtnPwQiX/bQyqdUpxv7xY
 sWOmaVksXt+PQO8fm00bzGkqo7rGSqZ39kq1avwTyOZKBrHgE3bVbm5SAL49wC5AP8zPzHrc26U
 xWEewmde 3L/xIsg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This attempts to fix the issue Ronald Monthero found[1]. Avoids using a
too-short struct buffer when reading the string, by using the existing
struct union.

-Kees

[1] https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@gmail.com/

v2:
 - Use BUILD_BUG_ON() instead of _Static_assert()
v1: https://lore.kernel.org/all/20231118032638.work.955-kees@kernel.org/

Kees Cook (2):
  qnx4: Extract dir entry filename processing into helper
  qnx4: Use get_directory_fname() in qnx4_match()

 fs/qnx4/dir.c   | 52 ++++++------------------------------------
 fs/qnx4/namei.c | 29 +++++++++---------------
 fs/qnx4/qnx4.h  | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 63 deletions(-)

-- 
2.34.1

