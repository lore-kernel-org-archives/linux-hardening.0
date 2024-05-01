Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB857165FAA
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605537; cv=none; b=gOSkQlrWg0iuQ2x8m3KI8R4r0TM+AnZCT9xMMyL+dlAI2Xlq0uOhWuZqhmVMC1YjpVxpHHBSFSNzXdV/9c3tfvaQLGruMKLMcxx2HiUd/wSG+Z+mCpzoj25lgd7EwmkrrLF/pWygGO+6/zXU2m1FjH1IeQYE2tQhaMiWcZ24rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605537; c=relaxed/simple;
	bh=7FXkbiF78yO95Ik6NVI4Nm2pb09Aq3YrAbf9O/PxWvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgUofAw7dnwC3voBulbg/gFozHY4DiL7fMucp//tQYKIQUKQbx6852CZNpgaf2shaiFiEhU6XpW6DEzmG2XJ6vHkrx8l3GpSFDWs1b2v1B/O21s7WUk9l3w70IPQJYUTCAH6QLJpU8tv6Cj+C9su98yWIinMGBeFzYpb5Bn+nOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PABHzP0a; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PABHzP0a"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7f18331b308so684245241.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605534; x=1715210334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FXkbiF78yO95Ik6NVI4Nm2pb09Aq3YrAbf9O/PxWvg=;
        b=PABHzP0aN1R0tz3YGI0Ot82xvogNHaT1Ev9Ouo+3uCM8EPMHrcpOUss16VYQNxWvsi
         8OOQ79i2+4qIjVIpnHnRr5OVyKqRimILYjJJQnG0LMZWp29BzQrbK8DMtG+bZV5AKQD7
         3AbDhHzu50wbRJWt5UDt6jXSVkN9wOC8Gbz05/307y+U1AgZVowEAch9cnt3gZ5B5+6s
         xCOZYmeUfXgg4GMGQLZzxUD5uW7jVr9xzVkekqYHZnWE/bR16vv5P+tC1+By1QTNbhMo
         RSxoFmBleOLngKt0W/Pd3qfL9tJa0KNS04H7LFfm1zgrzm5deFpL8PMNQazJ/VC6Udmp
         /agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605534; x=1715210334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FXkbiF78yO95Ik6NVI4Nm2pb09Aq3YrAbf9O/PxWvg=;
        b=LGOOL6RW/KRT+QdY30bk0eHOiKSWNZ8PMcZbqah2Sa+6cjWYcXsoTGjMOg6+L5kjWl
         hSg9rh5XDCaiVxlhlJYk+1Az6579HAQLIdEANUZOAlpqWWHmLxfRlPvwGpkojvMTccD+
         VkAD2HCoc1/NAn6vMPHdfKj7pdCeoqOhyF09NSrlmmYR+SRiUVISaW8us57pQlSKilPC
         fkFUbC0K3goKeV45IciWlDt805KPUh2A0/pq+iBKTNg0LjOwHILa50ahcMRmEh4VS3yx
         jNH7WvS3mQ4hWFFVPAOPee5W/hJfpddWI5NCjhIwsewq0LYsmhjGqGHT0P0IHKLaatQ6
         CXfw==
X-Forwarded-Encrypted: i=1; AJvYcCUuinvyEDS8GkzmnzYCK/J27R2oh1isILyqHq7BMvodTE+2jpEuj7KgRD1ai9B9TrESYOJTbBVF6Rg7BQdvYeCW63MoIC8FAcCTyaVI5IkA
X-Gm-Message-State: AOJu0YywtOlDUZt58jXHs5mjdTChbEslX+x5SsRtMC5YPl3BmKtwXMSo
	3ah0rFbj1iEKL1cQHE6a/xS9uijkS89cyoWpKEizDD3Pmhx1mB0NtbxqufmyfWB5JGaKyobB8Uc
	dE2Ud7f7/ZUu5IK9GjsjkzGBzguSe/aSfHAgZ
X-Google-Smtp-Source: AGHT+IFCNhW7Sr4LWQ18lqVtEBE5i75ngQX0dGbAlyauUArqJLvaZn/QyY35oTF3T1kZyxDYj2izJDA/UYjotSrmUC4=
X-Received: by 2002:a67:ee88:0:b0:47c:24fa:b627 with SMTP id
 n8-20020a67ee88000000b0047c24fab627mr4315116vsp.13.1714605534362; Wed, 01 May
 2024 16:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
 <7cdc63b3-31cc-442c-8c2e-75adb2c76b52@wanadoo.fr>
In-Reply-To: <7cdc63b3-31cc-442c-8c2e-75adb2c76b52@wanadoo.fr>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 1 May 2024 16:18:42 -0700
Message-ID: <CAFhGd8rO=-DYvXi0YHvQqnhTteV+Hgeuou0X3USx61oTobj0kw@mail.gmail.com>
Subject: Re: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 2:39=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Hi,
>
> Nit: The { } around each branch can now also be removed.

There was one line before and there's one line now.

I'll remove the brackets but I will briefly wait to see if any other
concerns come in.

Thanks

>
> CJ
>
