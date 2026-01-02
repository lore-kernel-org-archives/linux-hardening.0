Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E425C2DF3DA
	for <linux-hardening@vger.kernel.org>; Fri,  2 Jan 2026 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351885; cv=none; b=cJWbPNh3HkvySwzEpXd4NQNVIWSZm1G9Qzab1bBkn2G2xQiVCq059ASZUYwXeHLTGUWTk5ZHoQ8xsrIruXDbhkK+DT+iqRsy9nPWG0S23BZqKDwWrqwCmDf9V6YoNwTOTO1S+JgbXJPGSfwyK3wYGoo8yM4Z38rJi7q3abOkrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351885; c=relaxed/simple;
	bh=wSApN7eIEmxe+ZlkFun1Wolx+BI8xxAaYv9APOnMXbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpyAz8k3ufIGIZ2WpN8+mvMMBFGlSjY5pHVWh/jEajpAyw2qpt4jqu2wdCa9h2EgkKVEJjnSFCDmBT0FX+tFG/+D4D0cU9V0vFJWgX+tYIIi0XCEBZNGkujYbV2ApVJdOIZON63A5gRu4cxIoT4V3ptOLNtgt5VDa6VgcrGhmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipCfHJYf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipCfHJYf"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a07fb1527cso30758635ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 02 Jan 2026 03:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767351882; x=1767956682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIDs7EpZgwjKHQTJkjqicwJWn0vuoECrubEqmgA+6vU=;
        b=ipCfHJYf8oQoFqMJ+NDl0a9F86WRdEFeyHHJECOrCJTgF9zJ/8gSfv2wupCMMIxJfj
         eku/SNf83ymrhL/SQUYtzhPbgVk4ruSA1LYT9k/bKsYW9SrdCKgZevYG4Cg9TNfQwqoS
         caWuMb+pHVQgf1AW/BKGS9coLPWn9/MleoZ1hUJ6cuzG1lK59asRwBtVKq9C43ayEBWR
         qdj7iEyYMLFOU/K0uf6CjK8jVAxXEukfQluV/1sjZCjrJvwffOAohbgoIDdSsiOO13MX
         Ie2peETA/AJYICK2qlJpeNUpGfgbkOJ95hXdXg9xP1mWPAXH/MUYeYL6CVBcOSxhjMgz
         2WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767351882; x=1767956682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FIDs7EpZgwjKHQTJkjqicwJWn0vuoECrubEqmgA+6vU=;
        b=wH+sK+sueZZhRCfMtKnQF6YYJw2urFyHXObV3upgtdLM3fSswY300iNUTrr28GKAL6
         7CcPnYfp4J+xKMuTstyn5cnzM8HHEm1PuanDPmbcWrg6F/2aCVFyV60SZHDjKgqo0kF3
         Eniq7d9kg1gBOx8idur3DAux5nv/RrspX4sDANt2eyCA7r8kLplp+IJMGKLOcMnOxty0
         uGBwvyTPj39lrMrBXyLti1UVbL48brL5u50cEt1897K8Utjrbi04LPAHBPpZMrbFL3sI
         ul24ZyQBeGSzKiThIXZQmQs6UuC8OF/aGfEZG2ZkV8o0WmXQVsPAmV91TNhsGzdm4kWp
         bpGg==
X-Forwarded-Encrypted: i=1; AJvYcCXmaBnaoaNXf/DwfgLzzhRZGraYhzAD6776DyNvgqJUYc5fpISpZmRXBQFscVTe5Hn/XLLIQAViVhcUXMJhSpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXd+GRRa4H0eNBvRNBoLCFQzk+dpsz77Ow7tCDdmkqTWyeWOa
	GpW530ThFwOyy5GunPa13OYbY2IIvNsYiWosSW+MxDiapKIU3NSI3PGjzSUiiQ9uYJkY0EDSzl2
	EHnLi1v5DUq+oDepXUeTiwlnNAjuS7vk=
X-Gm-Gg: AY/fxX76BDWHy/2qobJUIbbUlUr31BfNwilcigTMsT+JBWG9IbImHzGNj4xxblIjSgH
	O31kmq90/K06VbSFCXILwEemd1sbaBW7wCGTXGOFzt4fOIsMgsH0whb5LQRK9ObMYG7pFmqCMLL
	BrS6TKbWBW95mjJTbzlDH8Fca5BZA3H8yvA6L0iNuitNK4I5kIYHPoRZDUcj5ySZ0zQ6wq7OmXi
	2pa/1Ek/qabS1/QlI70IULPx+SgabYaP6V9TKlrppyLXYMpPx0emBtWBtzOjKqHdC3WHfpQ5CTM
	O78exYy2nnDcTB2fgizeanDqYA1OHIcfb6axFhYYbS2Mh0GNivSIbkg0SkKvLi9vEidoWjCS4SC
	3/5piENpRy/Ns
X-Google-Smtp-Source: AGHT+IEZHP2Tt0L93hKtfLRSYNZV76m0YyhGtrMg6HK8YOKF7WDdzMO7LFlzqH2gnVcYBfD5MuH9A9W3GVedPNVkD/I=
X-Received: by 2002:a05:7301:1509:b0:2a4:3592:cf89 with SMTP id
 5a478bee46e88-2b05ea19892mr15172023eec.0.1767351882060; Fri, 02 Jan 2026
 03:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org> <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
In-Reply-To: <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Jan 2026 12:04:28 +0100
X-Gm-Features: AQt7F2rb7qQrF04KAinb0u8Ra4qw05S31gwaEul2jMZEj1pMA4QwOapz60W1DHs
Message-ID: <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] overflow: Remove is_non_negative() and is_negative()
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: Vincent Mailhol <mailhol@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 9:13=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu> w=
rote:
>
> thanks!  I think it's a bit sad to keep code only to make some checker
> tooling happy, but for now it seems to be the right thing to do.

Perhaps a patch to add a comment explaining Vincent's findings would
be a good outcome, i.e. explaining the reason it needs to remain in
place for the moment (even a link to lore.kernel.org to this thread
would help).

Cheers,
Miguel
