Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VooWjFQE"
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4FBD4B
	for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 11:13:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so1121564b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162025; x=1700766825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYlw/v9GVrPaC0s5UN9J8tYY4w/hsJ/PA3URh3Q8lJ8=;
        b=VooWjFQEZrJhPPuYBpbhtwGwIQgYGz6kH0inZ+g8mS1ynD+fdwb6NjYBvWs9iWLgRA
         9ik1hqeGW392s0wHuBgzAVv4Xio9IUo+99d0h2n98vq8bpiwCBIJ/zqooC//Mm0N22HC
         L067ds04wmKvRFf/0yGr9nxObGiDNf+s7KhrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162025; x=1700766825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYlw/v9GVrPaC0s5UN9J8tYY4w/hsJ/PA3URh3Q8lJ8=;
        b=MmHtsgCreO6+BmokkmZhFudbljKjjHFMCBFkYT0Q8zQbRBzbzb2nWAQ0gydvB54pyL
         Ny6WsRqr4LYo/e8+sdoekslt1z0F70tpxErrSHwBmqmtwQl7GA3FvKhHn90mG2Lvqrfe
         9gN3lPqASlIDMEeOTI5cw+PXixKERcgY/+qmR6lU2scjht9zpB0LeoROf/Y/HheoFCqs
         6DB/hnJaGvpjyGIZaFYjT0oSkVMV3jQBa/JF80TezlrD5Pmgr7smSLqzMlnBKjD0Bn+b
         /Oaw6D6sTwi90ut8I0Y+c+EKfev/O4Rdfvymp8YErQEfh6QeLAEHDkrbMVyaZ3YRgKOr
         TQNA==
X-Gm-Message-State: AOJu0YzIL6TeD0PMNycRPqGQbMTMbCsEwiXl9LBQ4eRJiYCKCHw0gYg7
	rWEplIbLvfAfCF+MsoYD+c6yog==
X-Google-Smtp-Source: AGHT+IFgcVG7tXCPsOyhSSlGhDJFcKq7oCg9wEnCj3YoT8Jr/uvJFGRO8OknbrQ7So0WvGIkyFeWIQ==
X-Received: by 2002:a05:6a00:4099:b0:6b4:231b:a45c with SMTP id bw25-20020a056a00409900b006b4231ba45cmr21865074pfb.26.1700162024994;
        Thu, 16 Nov 2023 11:13:44 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p11-20020a056a000a0b00b0068fb8e18971sm77330pfh.130.2023.11.16.11.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:13:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Kees Cook <keescook@chromium.org>,
	Helge Deller <deller@gmx.de>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] parisc: Replace strlcpy() with strscpy()
Date: Thu, 16 Nov 2023 11:13:40 -0800
Message-Id: <20231116191336.work.986-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=keescook@chromium.org;
 h=from:subject:message-id; bh=BzD7pn1JfYRhaoY80hkyIKEr+mEu4xES2K8u21WGIyk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmnklqIN5lZaW0f7xYsyH3WQSBx8zE4Qk3JQ/
 qbccTS4bEWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZp5AAKCRCJcvTf3G3A
 Jnc2EACuCUkbrGx9lSJGiaQGUafTwnelfTeuI404evq3xhBAjJHJhJCJ+uvTDfi1Pckk2n1LUMD
 QXo8pj48wa+jy9NQ0Q5+RSxyunjEvpbMaTRjmoVF1rlSMM42iCMihT/xBpWAm7LC8Gxr1551HxM
 eJ9I0uEQz+/MdFjBtxRO7YC2HAcwGsvuIrD5hHXD2mm4PbdQ8KdnoGY7iSWBpXd59Dwc+2V3DsC
 GrZTQ7LpjjsfziVRhVi7NmwSKE3FfcSd8fv3prm/DJl3SUAABh7IZFP3JvaSOG6oh3cP5lM2VzV
 2JKNorakX5VGe0Lq9GYpFGY4+XEkLljxIvYXYkgxjnbhM0KtRzB3mySyTAVMiRWOGzh0cJX2+KA
 8648KnwAHCIQKaOiY4wmF9YraK4DvjN8PTn38IXBQHipgJRXnXzbnDV9FybPxIeGdGYWPddV0/t
 SW8RXJ1Hv45wcANMdcpQ0g/6ZefeupFqVhrooMYOtnDIJUPAI0zSTLY44X1g/p5+LDIcT3VRyKz
 tqDDQx4/rU0UKiq1Y7V1vV2XtRJUHOIzJFdrSFaZCR655E2EaMqtHJdA612nQpspQl00NFCnmuH
 lBR2AZwCTYXLXJM2ia3p+h88JWMY+EGFjyBzF9P0yPp/IlqVr1v/sTnCrjdHTArUtOo51sDYTUm
 GjKamcX 6VghP7eg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/parisc/kernel/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/processor.c
index 29e2750f86a4..e95a977ba5f3 100644
--- a/arch/parisc/kernel/processor.c
+++ b/arch/parisc/kernel/processor.c
@@ -383,7 +383,7 @@ show_cpuinfo (struct seq_file *m, void *v)
 	char cpu_name[60], *p;
 
 	/* strip PA path from CPU name to not confuse lscpu */
-	strlcpy(cpu_name, per_cpu(cpu_data, 0).dev->name, sizeof(cpu_name));
+	strscpy(cpu_name, per_cpu(cpu_data, 0).dev->name, sizeof(cpu_name));
 	p = strrchr(cpu_name, '[');
 	if (p)
 		*(--p) = 0;
-- 
2.34.1

