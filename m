Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ECB39ACD
	for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746519; cv=none; b=u/wUd7Umty9XgGYOyalvZVidwxoVcwcdUcoND9bCu7e9AZiGmUyrkHnytus1DpYSZ9OsX7OKhLycTuysHGKEs/2Q/VvzYSRlymABEl3D/lLSPHb877NNvyeLZWzwxcwpxWbXPN2y7hvbJKwVesRWM/l7b4IN7o04FZi6oxLe+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746519; c=relaxed/simple;
	bh=XhCwhjcGydXDxiHtSK4BdYzcSeAyPu3k1yt7vJg0K8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANiclDXTHZJlOQMH77x6AJpZlSX41OOoJnmxJYsDSF567YI8w1f+M9+/dgoBXzxKFAOUmcQIbMxRpgEy6icLhSXmqvpsZXmyBMKefOuJ45zD7E/dfD6YxrD74Yg9ysxk0XxGb3J6TKUuFwNC6rt/mC+lmeEpYD8J/uhauS35U2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gB0xY7QI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gB0xY7QI"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so1218662a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 21:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715746515; x=1716351315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r4cKs65r0Vn5NjWdK37SwLqUt+S38IkvifOxEI5Gn60=;
        b=gB0xY7QI13SoovoQAIXfvmPOWNIqYfa3mhpEITLW7Ppc0SzChw2CsYybNFspDIAZOX
         E3R40hQ7HiC14EhwO4F3DEcO4Muf6zDSQg8R1vZwSfj4basLhU69CAbVnOwU6kgbkXAI
         JKjMmRBJaSLmOk8H2jTszjAsDKosxwidkukoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715746515; x=1716351315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4cKs65r0Vn5NjWdK37SwLqUt+S38IkvifOxEI5Gn60=;
        b=QAxGFTMYAg7naedWabDa5NqZrVQHP4zCtvTNdshiI8ydp8IHu4qtL/pWNqhpbKIUwv
         nhBQbFSoWO43OGY5ewydqVbGeefc488q3m086NrPVeABCUlMcdVrBK52NYj3MrY12FIH
         YQbArEZSKJABbedeWf7aQreFWpl7JEv7m7S+aT+jNsJjTShGDz4dedIh6xHpfcBXxOLY
         AkDmodsAmQJHxneAsH7krNmUwRAHbFvOWjCbYH43nM3Hu9OEHxM0yUhwlUV68MTUzQvU
         97TrH/HUDS6B1pPUJSZRO4RGqhyGfiI8oT0dZht63xFMEYTf0dLc2ZK7XZGO44WsNs4n
         230A==
X-Forwarded-Encrypted: i=1; AJvYcCVwzLxu/hPI+eSnulc9McU369QQ5E+BtsGAavaLWRbw+vyUmDTeAkVv9CAGZsgK1X2pYIiUJ8ei01EhmNbGbCcwtxmpZrmI8OwGZqcKG3Os
X-Gm-Message-State: AOJu0Yw8J1Qf2nFbHvrXGij1AwJhrMfwt/szHUujzQEI5u4HMuAMU3uu
	Ap4P0OlJFap3kDhcrwpAF4msHr8h6wZmu4OkYk8Sm/xtazy2LSzfl9d6/uBa4TWdBfrE7GJAvWA
	5d92m7g==
X-Google-Smtp-Source: AGHT+IFPVFzqIH5fVhZzN5IOVjRPI8agFtRaupudpnNVxojgc7NkAVw2IfbjMOAJ+rSwgKRD5E65ag==
X-Received: by 2002:a50:8a95:0:b0:566:2f24:b063 with SMTP id 4fb4d7f45d1cf-5734d5e4ba9mr10601079a12.23.1715746515555;
        Tue, 14 May 2024 21:15:15 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb56fsm8326242a12.33.2024.05.14.21.15.15
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 21:15:15 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41fe54cb0e3so39814035e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 21:15:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUo+PPYLZFNXFu6dRN0mYafB4gPbTrbE/zw+hE8J1zoiZVNPbBUdWTfTnY56ppzz/aKV5zKCyvOx3+R5vFbu9Ov0kN8Z+c2AFHnvl2ZQRWW
X-Received: by 2002:a17:906:dac3:b0:a59:b6a8:4d74 with SMTP id
 a640c23a62f3a-a5a2d3bebeemr1157374666b.0.1715746493951; Tue, 14 May 2024
 21:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
 <92453.1715730450@cvs.openbsd.org> <20240515025811.GA1232@1wt.eu> <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
In-Reply-To: <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 21:14:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_GHCwCiC-ZR=idjNEb0xZq20=fQnQxnjGkiq-ba5DLg@mail.gmail.com>
Message-ID: <CAHk-=wh_GHCwCiC-ZR=idjNEb0xZq20=fQnQxnjGkiq-ba5DLg@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Willy Tarreau <w@1wt.eu>
Cc: Theo de Raadt <deraadt@openbsd.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, jeffxu@chromium.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, 
	Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 20:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Guys, if you let untrusted code execute random system calls, the whole
> "look, now unmap() acts oddly" IS THE LEAST OF YOUR ISSUES.

Side note: it doesn't even help to make things "atomic". munmap() acts
oddly whether it fals completely or whether it fails partially, and if
the user doesn't check the result, neither case is great.

If you want to have some "hardened mseal()", you make any attempt to
change a mseal'ed memory area be a fatal error. The whole "atomic or
not" is a complete red herring.

I'd certainly be ok with that. If the point of mseal is "you can't
change this mapping", then anybody who tries to change it is obviously
untrustworthy, and killing the whole thing sounds perfectly sane to
me.

Maybe that's a first valid use-case for the flags argument.

            Linus
