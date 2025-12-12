Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23228308F00
	for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529398; cv=none; b=qKbwh5eFES5vfY1swBfvFX6wPfFdWHkLHd0KVJu1Hwtsr1i48A1fBrCCZpxxFuAGFieP/9V1ps3yGEFIpLF+9Nb/aizMZP7C8A3458250zxZrA65gyGKTtBb2tFj+JrALIN8tNhKe86oEj02gm0AHJSkSVYL++Uw81+tkQtTVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529398; c=relaxed/simple;
	bh=uEXD+fl1VaMsAi+rOzB/qKb7cAebaa0SHJ9PEe/VNO8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q9ubG5U03TDxGtw5Tkm6tYfkX8K4GDrd6kbV7LHZC1up81XD3z74lUsXxZL8QMAmjBoz/NDNADKdevanpRVZKPICLmzBvOyzFvq7PV5dMbTVaS+u2uND3iJ0NYWXn8zu7OD16eGxtriw8vhqhdcNL6qcU0gZd08V0JNIvmL5Xdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsNNWqc4; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsNNWqc4"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37a33b06028so9079301fa.2
        for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 00:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765529395; x=1766134195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEXD+fl1VaMsAi+rOzB/qKb7cAebaa0SHJ9PEe/VNO8=;
        b=EsNNWqc4433YvIgkkhRTrFG8awpVof2pFounGRHC6xorCUftsOvD+j3tQ7Ibkg0Lkt
         Y2/y0DX+/BTKuCiYnPIl0psG0SiuzxBv2etdHlWW/0Sll7CTLncZYfB5a9JLXEYvPklC
         eB85tNDmr+xSvvNS/pAjp9K9nojEfsvbpnxNfaRIIfrSUw4Z+74Ks1yHGkfhYxtW7L44
         ljHSRf8ufwxjjLKmzqCCrUUkkdLDTKTAnlo8G9nd7/ANUVIzY2FSzrLLGT6cvlZI90IA
         QfSxL090R+Z5v6LmVXZAJjv3i7Nvslg6LwWFYqAoNuZN4pdWsk6NQzrA4ZezqAsZNkyF
         K8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765529395; x=1766134195;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEXD+fl1VaMsAi+rOzB/qKb7cAebaa0SHJ9PEe/VNO8=;
        b=wAwV5CjyeAstLfA+WlI00SuvMklxJOCHJtdU6ICK80xlyF5twxP/HdhwO7coV7Bn9o
         NMAHB2wkHD3anhGomHk1AuikwDlMrKqO9Hd1klcuXDjzJTiE64kxa9XCPSzDzh3jcnm/
         ZGZAcL8x/TGKBNgqKSSYsW4sI8woOQ/Jc1yEVnHJwMozLL9e+yLv1lY7LOuEgoz4jX7m
         DClwZfBgoX7WXHBZgeQ7WFsU03YwWL2l7KiMzsAU2WZfuXf2j+lJpvnHheu/oNkILVmk
         Qp2PjI2IQWiydwagyklITJVKOz014awBOeEZLDidI7psUpEcfFAnHMpW7Qa5b6V/SvmX
         YKEw==
X-Forwarded-Encrypted: i=1; AJvYcCWDdVsIeW190AEQfexpZ+5zFzBXOoXfa+Y4o4jOVxn9ZQuODrPerU+PECCnRtRmvjfQ1I5YpyTeJkcqLT0ssFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbfS7bCygoi7EjHeTZZv9By4LuupP54DoiFz+z6IgZG1VtUh3/
	cH9Vad4ohVaZYkN3CGwKN8PlBM51gfJH6q60o7t1265CdZ8KMzWU4i6tOfM71o7uAKUYV/RQ0og
	sc9r44WN39UC1YmfkJdhCaaVDWbx1kDg=
X-Gm-Gg: AY/fxX5rfyW14K0BkbIH/ik7vdgcfGdoqNWtZkPBDGSA3Cd2IJTlv/2w4RkSQdOQFAN
	AGGXwvuV+k5AqsMDFq4yyOVUjfNOHAS+za03kC6hWN+WBhqYGxmklZfcvbchC5/ZMLvEy3hXArM
	2e3xpREiDrDq4J1Xlivb+ErV9LojpRpiUF+ITMyKFyqSLuDkvR8wrOKl9/WOHI/hVIKOjFnrqEK
	/nXrXsWgyGD1sPe3c0h2BIxqk2G9TcRcmrWqplI+RYuNGdyCkgBNj8r7OZ8X1voM5XVCgYFP++Q
	GkLGw3yZefYN0jFCX3mJ0uU942LB
X-Google-Smtp-Source: AGHT+IHtqUZX4vVesa0t6KZet3L60PV7SBPibR53J9EHZRf/1SiaQqpFxmCqV4+n1A+BVBTgbyu/4Hy3MbflM61OujA=
X-Received: by 2002:a05:651c:210e:b0:37f:cac3:c280 with SMTP id
 38308e7fff4ca-37fd08a22a0mr5090041fa.33.1765529394838; Fri, 12 Dec 2025
 00:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 12 Dec 2025 09:49:17 +0100
X-Gm-Features: AQt7F2ohWplDOv5RTh-KQQ3ppyn50BBO-Ap-Pz1SuupVjkC3VOvw6eMVkUMhsfI
Message-ID: <CA+icZUXPcT0gQbp+oXiRNE0yBSvLGWWvP93kMPGdcFJjW52n2A@mail.gmail.com>
Subject: [PATCH] media: solo6x10: Check for out of bounds chip_id
To: Kees Cook <kees@kernel.org>, Bluecherry Maintainers <maintainers@bluecherrydvr.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Andrey Utkin <andrey_utkin@fastmail.com>, 
	Ismael Luceno <ismael@iodev.co.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Kees,

Thanks for the patch.

Feel free to add:

Reported-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v21.1.7 x86-64
Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v21.1.7 x86-64

More details here:

https://github.com/ClangBuiltLinux/linux/issues/2144#issuecomment-3645456824
https://github.com/ClangBuiltLinux/linux/issues/2144#issuecomment-3645492492

Best regards,
-Sedat-
