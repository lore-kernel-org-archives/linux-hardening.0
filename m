Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34DF239BC5
	for <linux-hardening@vger.kernel.org>; Wed, 11 Dec 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914029; cv=none; b=huEc60jHuJTsG5Hvu2Ce2GxLggMb5ouc1fi1F+1CAJS9OAJpoF6iNp5HcLwR0K6AseWjfkvphId3ov0AC5MLeIOFL26OJ62ZK6e6exEy0Dnx1lJwSXpuibajuV0RquzwmvEdAomWQM8b+kDsc7dCLzI7cBnQFvZxNKYUkYCs2mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914029; c=relaxed/simple;
	bh=nKjcDcJB4jySgsM+5Bv4lh0SR2eEjEafuclhhXKVV5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ch8et0R4r3/49kDh8f3ciIT6u2mMfubZYNaApwJNqtYZYmZoUUTa1sjRwHdWwhrYYB8pXpnvyrArOIN+HnYLfm4ljpcY/eZeidSQFiJeihlLCZqNSiPcEhJeT9UjNaeU8fUXtE+wc8TjXKc6wVsHPVihxIqynP/ixkN7WZ0EjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=Ye19dIQG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="Ye19dIQG"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd5248d663so2507700a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 Dec 2024 02:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1733914026; x=1734518826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKjcDcJB4jySgsM+5Bv4lh0SR2eEjEafuclhhXKVV5Y=;
        b=Ye19dIQG393nM8RDbMcfNqLa6sVAhNCHanOC9iIAZc5ijxmQVYWlidQ+3rHpdrnunY
         YAmwC/bFvZ9ptLCznDGH6/fxKXHr/r4nGQloBvEGH5OQ/Ny6BHlNLTMdHYK29lHe3mzq
         bjYLsjZxUtyG3E+h5ucNeULAujS7m9p1hpUBJL2P5IH2m8T8i/oQPyNUaeyeKqqSYFVu
         E2h23nDJveeVvMWTqdBNturic5O0Fx1AgT/yOOSDG0Nf1ve/modFcg32hFUTpI92vxUi
         cWVIZVHzcAqCR/TGDIUkkYPnxtbulSmHh9g13Yyv7gaBy8XIK9kBDnzH4kTgaHD2E8mf
         2kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914026; x=1734518826;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKjcDcJB4jySgsM+5Bv4lh0SR2eEjEafuclhhXKVV5Y=;
        b=XSk8dlNIvjaiQCPxB9CZ3w6doWmKqp6NftnjVnum+1b6gKfcPgiAbh/0o1aClH8UdB
         40G6YXzQzOS1KvY+r905cIrwVdaEFeJSRMn+F5Ed8kySVhyBcLMkN68O/IhfOci3tosL
         cPutbSabDHxQGP3um5I8F3c62KZN9BPwB7pOTaGUEJrlbuGSewMI1fy4MrUj045wizJ5
         PBPFrnuvvVpuFh7+u05g9iJ6ja5QQpeByEJ0DmYIf9XOQknTZHdKNSxBrjKZb43Z5N9d
         J5p7mIAL48EYHBcGBDdgttrUl/FgHLh+yk6D/z3NA7YnfJgGPYSVoTqK5iD7tRwPg9wR
         sRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcip15+tKzAqQfnS3xhWL/63FQ1F2sqVhHmd6U4hEo8yEgbHe3tC7arNP4pKZi8kM9UGL8WTzq4rl3JcEeF28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBIRZiJo35sVdK6fIlDroPOwLItS+ZV5FmEtB9wSDdjy85mTn
	OeYur4o5yLhyuQXHYCrgm3Ej43Y4ZLqyGC0LW76AeYtXijeC9QBOqz4l7Mrg+5eJVHl9qpV6tCo
	1x2KsjUUW/0Kfaa5D3t+VxezxirTUEGds0nCG
X-Gm-Gg: ASbGncvmgD2UanOoSKVlFJKUO06bJyABUBPNCTdnL/qTBA+DpQnbbzc420KsRT+9b78
	uqbfI4lMi3stZd7BJYWUhzXpdQIn6OodrNWnYN/ycSuQRbETtSLi2VRmxTC9dOtj60bg+gQ==
X-Google-Smtp-Source: AGHT+IEfc10uei7wMAJXp3wNIDyhS3tTRIVNGgwU+Xml++f4NrLtyZznzfdG3yC/KG2xrJEx7qUX2s8l+mP+Egmyjxk=
X-Received: by 2002:a17:90b:1b47:b0:2ee:5bc9:75b5 with SMTP id
 98e67ed59e1d1-2f127f8debbmr3550949a91.4.1733914026227; Wed, 11 Dec 2024
 02:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 11 Dec 2024 10:46:55 +0000
Message-ID: <CAHbf0-FQCNkOg4F=cjOCGsD0QzxrSj99ssYaH+9A=GnSn+PqrQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: replace deprecated strncpy with strscpy
To: justinstitt@google.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-hardening@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, martin.lau@linux.dev, 
	morbo@google.com, Nathan Chancellor <nathan@kernel.org>, ndesaulniers@google.com, 
	sdf@google.com, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

I'm not sure if it was this patch or an older one but I'm seeing the
following warning when compiling/linking with Clang 19.1.5

vmlinux.o: warning: objtool: ___bpf_prog_run+0x44: sibling call from
callable instruction

Cheers

Mike
