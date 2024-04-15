Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4CE3C3C
	for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188762; cv=none; b=KsUKmgpnmnQ9xsXaP5lhXzN+Ps58ecDLcV3UCtRMmI5LSc75RViTKJckOUtOf8N3r6oM5NHUOTL1NcP9R4sKF8YAIwSZYUqf3jvOAN1rtM9lxiDNVOBIdYLgypFG67M3l/UGvxqQmBFEkQSdNTO5oFSbaFMB0xNRc+GlZY6Ohok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188762; c=relaxed/simple;
	bh=HoTys+Q/WnRqISBzj9/nNxzDgy1VaiRBHP8eqle1x9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tgo5kIha1pqIee+KJdIDrLiD2htJ2kbPlvtVIibMNDDu1ftwO6rDLqTVUE0MaMOYVIo9r8BfnLTPgDzuXRurePN0MBYF1tUnNA0B9WKHMPR4Gcw3RDHGamUztDTYaX0WSWUbHek1ksT/Gs10EwqxpG/DZJHdYrz3IMQ2/Q+RghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVf+YNz+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVf+YNz+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso2520686f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713188759; x=1713793559; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tFic6asmsSS4GxpnpFHB7llM++UFIY5gXajahwq1PxY=;
        b=HVf+YNz+WHrNnmwQ+LKO1Sm90/ogLwpogazVvf4v9jA83/qmVrNFq/Zl6Uzr3XcMHq
         wWXwNJZ+TMF5E+ShbqvWPZ1fZ3KLhXRhnOgNLElvOuvhcYsebxLqE38Mt0AnpHTPYWGa
         gOLTU1kfyNAdWlfmggGVAdxtXioT9gq0PiARJEY3U8n19ltLGaUkhDkjkY7DiXD9TIqL
         sfx2uNW7nu4kIej5lRjEM4GShG2l0twTDTNLFE2F4skJMa7MVdLYggvuJm4MZzKphCHR
         hRUlnQK9vwJdLRRCM0uFa1OU48mDHeHLf2bkbrv+E+lBtKZm7F0VpeBW51VeJpPDWdiH
         x8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713188759; x=1713793559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFic6asmsSS4GxpnpFHB7llM++UFIY5gXajahwq1PxY=;
        b=VxO/p42AIpQaNDN8G+jixEatniBEaWvN4Hy1usaTt+QVo5YzcAkejeCmi96DLhUOYO
         ewTGPDr1YAX1a3yTDu5uFLRLBdgxO6IUthLOBckdfNIRiT3kVZeme+CGoBkma5pZG8VC
         ZtX0e4E9lcT4LSqk5eeuPOhnZ8maw3b5ZwSR6OztUZgM9ePR26LHOXbd/dP/SuWzvOPo
         ffzYeLSoyUxuQ37hNua3rP2wogv1hE3hrKdEmcIXRYhvmQRcyBaizHwlFLlqafX35nqU
         +jiohPlMXbPd64T8LS5vDxuzcO+ftlT+4RU2Dtva3Z13tXRsF6vioOtYi4+HvrZ3aPz+
         wccw==
X-Forwarded-Encrypted: i=1; AJvYcCX9p9Xs1prjPgR+yyIlRa+LI2zn62ePGqa3Z3f5riX+FmtRWGm8a91/5e6afuIFuwK840T1Fp7Xz5y3btB38fGWz1u/zOWy19UhjOn9iFad
X-Gm-Message-State: AOJu0Yz4Gd1aNWPIET6Nk/0q2PdTLH/HJl/WMn5boGLRZnh7pM2yxJcm
	WgQpMK8W9iWWYui3xeIpBYasL9RbU7fl16OYKZd/hMZSAgOJu4ajSCgPlWTyQ54=
X-Google-Smtp-Source: AGHT+IGtEZhJYcvyjUaVR5q7Z3EL35x0pB8Vqt2ojfVp/KteirYWhqyPS4ibiVPICSxTCCqCIBmRvg==
X-Received: by 2002:adf:e286:0:b0:347:9bec:9ba3 with SMTP id v6-20020adfe286000000b003479bec9ba3mr2565872wri.66.1713188758769;
        Mon, 15 Apr 2024 06:45:58 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d6852000000b00343e8968917sm12249163wrw.1.2024.04.15.06.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:45:58 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:45:56 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] kdb: replace deprecated strncpy
Message-ID: <20240415134556.GA492724@aspen.lan>
References: <20240405-strncpy-kernel-debug-kdb-kdb_io-c-v2-1-d0bf595ab301@google.com>
 <20240405095144.GB2890893@aspen.lan>
 <CAFhGd8q99emm1SFJSs=L7Pn0A79vCtDHtTD5XUbVCNh=DDadaQ@mail.gmail.com>
 <20240409183558.GA7510@aspen.lan>
 <CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+LqvC8deA8GziUJLpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+LqvC8deA8GziUJLpw@mail.gmail.com>

On Tue, Apr 09, 2024 at 01:48:38PM -0700, Justin Stitt wrote:
> Hi,
>
> On Tue, Apr 9, 2024 at 11:36 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Mon, Apr 08, 2024 at 05:46:42PM -0700, Justin Stitt wrote:
> > > On Fri, Apr 5, 2024 at 2:51 AM Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > >
> > > > >                       len_tmp = strlen(p_tmp);
> > > > > -                     strncpy(cp, p_tmp+len, len_tmp-len + 1);
> > > > > +                     strscpy(cp, p_tmp+len, len_tmp-len + 1);
> > > >
> > > > Again, I really don't think the third argument provides the number of
> > > > characters in the destination buffer.
> > > >
> > >
> > > Right, the third argument is the length of the "remaining" characters
> > > from the completion point.
> >
> > Which is not how strscpy() is designed to be used.
> >
> >
> > > if you type "tes" and press tab then kallsyms_symbol_complete() will
> > > populate p_tmp with "test". Prior to rendering to the user, @cp points
> > > to "s", we need to catch the user up and print the rest of the symbol
> > > name since they've already typed "tes" we only need to print out "t".
> >
> > I'm more concerned about the case where you fill the buffer entirely
> > then move the cursor left until you get to the tes and then press Tab.
> > I think at the point we write too many bytes to cp.
> >
> >
> > > len_tmp is the length of the entire symbol part as returned by
> > > kallsyms_symbol_complete() and len is the length of only the
> > > user-typed symbol. Therefore, the amount of remaining characters to
> > > print is given by len_tmp-len (and +1 for a NUL-byte).
> > >
> > > So, yeah, you're right. This isn't the length of the destination but I
> > > don't see why we can't use memcpy() (or strscpy()) and have this not
> > > be considered "broken". The pointer arithmetic checks out.
> >
> > The problem with substituting strncpy() with memcpy() is that is *not*
> > obviously wrong... but it could be subtly wrong.
> >
> > We can see that the person who originally wrote this code made a pretty
> > serious mistake with strncpy() and the third argument if garbage. It is
> > therefore important to figure out what the *correct* value for argument
> > #3 should have been *before* we attempt to replace strncpy() with
> > anything.
> >
> > Transforming something we know to be broken without fixing it first
> > means it is impossible to know if the transformation is correct or not.
> > Hence the original question, how do we know there is enough space
> > after cp to store the string?
>
> Gotcha, I will find time to seriously refactor/rewrite this function
> (or at the very least the tab handling part of it).
>
> At the end of the day, though, I just want this strncpy() gone.

So... I starting looking into what it takes to provoke kdb_read() into
overflowing it's buffers. So far I have found two ways (one of which
does affect this strncpy() code as I thought).

I took the view that the strncpy() (or any other copy) into
tmpbuffer/p_tmp is just the wrong thing to do. A memmove() is simply
a better approach!

Short verison, whilst there is other refactoring needed, this change
fixes the overflow. I hope it also meets your ambition with respect
to strncpy().


Daniel.



From aab83fc9d0e97987fdec51613b536fc32a63c544 Mon Sep 17 00:00:00 2001
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 15 Apr 2024 14:35:06 +0100
Subject: [PATCH] kdb: Fix buffer overflow during tab-complete

Currently, when the user attempts symbol completion with the Tab key, kdb
will use strncpy() to insert the completed symbol into the command buffer.
Unfortunately it passes the size of the source buffer rather than the
destination to strncpy() with predictably horrible results. Most obviously
if the command buffer is already full but cp, the cursor position, is in
the middle of the buffer, then we will write past the end of the supplied
buffer.

Even when the buffer does not overflow there are other problems when cp is
in the middle of a line. For example the cursor position is not updated
correctly meaning what is shown to the user on the console is not what is
actually present in the command buffer.

Fix this by replacing the dubious strncpy() calls with memmove()/memcpy()
calls plus explicit boundary checks to make sure we have enough space
before we start moving characters around. We also add a second call to
kdb_printf() to fix the console cursor position if needed.

Reported-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9443bc63c5a24..3a1b9dd890f45 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -367,14 +367,23 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
 		} else if (tab != 2 && count > 0) {
-			len_tmp = strlen(p_tmp);
-			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
-			len_tmp = strlen(p_tmp);
-			strncpy(cp, p_tmp+len, len_tmp-len + 1);
-			len = len_tmp - len;
-			kdb_printf("%s", cp);
-			cp += len;
-			lastchar += len;
+			/* How many new characters do we want from tmpbuffer? */
+			len_tmp = strlen(p_tmp) - len;
+			if (lastchar + len_tmp >= bufend)
+				len_tmp = bufend - lastchar - 1;
+
+			if (len_tmp) {
+				/* + 1 ensures the '\0' is memmove'd */
+				memmove(cp+len_tmp, cp, (lastchar-cp) + 1);
+				memcpy(cp, p_tmp+len, len_tmp);
+				lastchar += len_tmp;
+
+				kdb_printf("%s", cp);
+				cp += len_tmp;
+				if (cp != lastchar)
+					kdb_printf("\r%s%.*s", kdb_prompt_str,
+						   (int)(cp - buffer), buffer);
+			}
 		}
 		kdb_nextline = 1; /* reset output line number */
 		break;
--
2.43.0
