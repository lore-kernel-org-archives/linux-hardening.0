Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED21448ED
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jul 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162633; cv=none; b=GLGuM/ke/+SdGQfGy3qsUNZYv4deTt0BGkvxm3Euvy7D3FwpO2lQyj8go/i6L7+LpkHK1lUAJ0C+kxZukiNH+JPyUYzbrX+ZR6gh9rzgSYeJyQ/8kv2ivcLMcjjHTx9NCCvcC5q07q83aBM1ZE12zd5Ub7JwYTrERlsL0O7oQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162633; c=relaxed/simple;
	bh=1KWCKv/9inKGII7KtToWHIt3Df0DdcGGOvAj6/wIBTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSHhLL/Efqh1u2NCR+kiGfDJnZ4rf62a4Qilqe/pK5Mylz5ATDzOIIUzJOTjKpchHUJdNiCapJXszks7YW4EbIUiT2c6lYct3nX5iE6yFCgA4E3HTEx88qiVxqtBCWiVugTTK9I3gwTjA+uiyMwwpt4N5T5qb0IjU2AaL7jJ6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TEJl6pAu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TEJl6pAu"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so71709271fa.0
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jul 2024 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721162630; x=1721767430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUaHQYTLzRHBKTZzDYfY3JozSjPXKaeTqwHBAMUNNtg=;
        b=TEJl6pAuZmYe/ZF35fsXHCcXu+ZmOKUnBneMhW/bYrY0T+F8ZYBnNLany/x9345VEu
         LaXagyyBbRN1v1awNaM8+fgV5lkoQD4VDIiHUd6/KJp5Gfi53f2UsMBdYfdRCBFKTkdL
         dZLY7SiHHQv7TyWhPUZ8FNL3mMyXuOBsfDa4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721162630; x=1721767430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUaHQYTLzRHBKTZzDYfY3JozSjPXKaeTqwHBAMUNNtg=;
        b=oWCy7ZZPxpqjN0as2Sv/sXHh3S6MPOJWgHZTb+iTwqEMeSbpkGaaONW9MZ7cK2Bcm5
         K/gRcVXOrMJpsmLdG8nVFQo3difKzDSY6cwzPN2kjBn1nt02s0VZJOk8mn/W8Hqpp3la
         pOviQNlhFQHEdA3pvZenlHXS7ssqKJdqu56WptrBitOnJXEJW++wrloG2/lguXFOuIIu
         PIzjVmXZsccRQm5TNOtx6A6gQ0wzKE+zD0d3rSBjXdDZbKboPi87uO4mPhkizUUPRHWL
         rB0ghZmRN5XduFSL/z8yAgAWauA67JH07wysElxW0T7KCyDtr+QiBqnb4p+cK7ayThUu
         nB8A==
X-Forwarded-Encrypted: i=1; AJvYcCWWepL3U6vj9RZuDbERwjj/yLad42LNdfPXY+d76JOK5Kj/Rbwg+PhwZRRWlWzjLdETnhvS4sNTMRo53oL9rZvAavVel5zP/H+z/hZa+Vs3
X-Gm-Message-State: AOJu0YyHzhEmI25iRJI8FYFEJj8QNKXjnTP2D/N9SeRM0SV8lyP+/H/A
	i33W7mtoC6bQu+2b7ouCWbbRwcXxxZqSKUlxfDKl3oLKp0809HeLAneHP2KBwxadaiXPYFvnWl1
	VtggjZg==
X-Google-Smtp-Source: AGHT+IGWmqCTMyOqBqezpt+wH8kxv5k6E5kmWuT/F3RXJYRVdtqYFJ2t1AWMKwgxKWXDYIxSauNGHw==
X-Received: by 2002:a2e:9e15:0:b0:2ec:568e:336e with SMTP id 38308e7fff4ca-2eef4159e74mr24647891fa.1.1721162629789;
        Tue, 16 Jul 2024 13:43:49 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b25528e18sm5478428a12.56.2024.07.16.13.43.49
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 13:43:49 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77c080b521so631988466b.3
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jul 2024 13:43:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrTuf/FYDtvIQ1VEcRIfc6ml7MRKwDxZEBwwQZpsZhLu0w534Lnz3pXiva/IplHP5T7QxoOtGosc/LBD43GjN71g0VRYlI2FWLAZzzhvlk
X-Received: by 2002:a17:906:7c44:b0:a77:cad0:5a92 with SMTP id
 a640c23a62f3a-a79ea4367a8mr225972766b.24.1721162628850; Tue, 16 Jul 2024
 13:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407150926.4864BCABD8@keescook>
In-Reply-To: <202407150926.4864BCABD8@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 13:43:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioGrBpYXENm73w0OHvzhFtETgkaUH+5LYovRWOHJpZ0A@mail.gmail.com>
Message-ID: <CAHk-=wioGrBpYXENm73w0OHvzhFtETgkaUH+5LYovRWOHJpZ0A@mail.gmail.com>
Subject: Re: [GIT PULL] pstore updates for v6.11-rc1
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 09:29, Kees Cook <kees@kernel.org> wrote:
>
> Please pull these small pstore updates for v6.11-rc1. (Note that since there
> were no pstore updates for v6.10, this is based on v6.9-rc2. I forgot
> to do my traditional merge-on-rc2 for this tree when v6.10-rc2 happened.)

Note that this is exactly what should happen. No need to do any
back-merges if some sub-area has been quiet.

Sure, if some branch is *really* old, you might want to do a
test-merge just to see if there are conflicts (either textual or just
due to infrastructure changes elsewhere that cause old changes to not
work in a modern context), but honestly, even that is just a "nice to
have".

But "missed one release" is not very old in the big picture. We do
releases relatively often, after all.

So then merge conflicts like that are on me as a top-level maintainer,
and if they end up being very complex I might come back to you and ask
for guidance. But honestly, that's quite rare.

IOW, I'd much rather developers concentrate on their own branch and on
making it very solid, rather than worry too much about what has
happened elsewhere meantime.

(Of course, that's all for the simple and good case where you have
clearly separate trees - which pstore largely is. Some other areas get
a lot more "this is affected by other changes and in turn affects
other areas", and then people there have to inevitably be more
involved with what has been going on).

                 Linus
