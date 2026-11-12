Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504217;
	b=X7OwiJbHA2+eI9KI7SQFbgEIgAlwDhEj4lrrjEvH2H9iyoSqKk0jd1yQzvRXvvgS3M/+
	 MA9PU4bSLXGj97qw/BYdcX33xXyDrJnTYN+Zwo1x//inxpi/YhwsSkHG/yZzKmjPilQND
	 JgD84YwDf7FJmZPJqqGQT4ub7h1SFzY5ZZzQZikXDPRdeJWAeWDz7DUJSlfXYk0E558qs
	 yQKs16k7if1bfepWW62SZMhPYqBo5EqK2O+2slGDp7tX/1IBXUjGah03EjEfGRvbJ8i37
	 beeMCP3g1hxnX8fRpDlM1to9l4M1besAT+/m4ainwcjQhnZrTmwuZdyXDu2ABeWp5Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CPqL/jXjgacEff5dEPASqy6/Bbk+NnoKXgfKHY7JVag=;
	b=vl4O+nfy5gL8JboqcfV6mhblGlg+wFOmq5ClL2N6HN6L7nZJviR2rdNFk9DjUC/+EGk1
	 P08zlPeuj/rVnQ6tBUH4/M0R866ULvBRq3M1T9blKxL2O0anRdOgJCPU/f+JbSW99rsjF
	 FfsL+RIjHLOmgzI1Xn98SsnCW14dWkiPlIswNN1uE/lFceArCtG/v8+obXUQ+2BdGnncb
	 aH0ukwudUXB67zoV5M4Dq2t4aveOUEh2ZQgX7Djm9MqECSLkVZox1nCBx+pDB18AGPN6J
	 /v+Tdg23bWoKyVa5LTXZgJyr1/1YN3jm/MxLsBpGQgP8vL8P+196aBzgwNXZsMWvoWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Gx7py7bJ;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E4606A31C
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 17:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 601E4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Gx7py7bJ
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso49928a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 09:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794504215; x=1795109015; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPqL/jXjgacEff5dEPASqy6/Bbk+NnoKXgfKHY7JVag=;
        b=Gx7py7bJqnuJzaODcnZwn2ksXw0n3M4na/4CCr7bYh9jsFNkfPQiDuVzGaMhJUH0Mt
         8gpn9mQeUbivywi6uhHmQDFnWmh7ZT/USOs4Gx/Ar80c4vjtEhwrq98h8K4rgX5T+sb1
         fwoEiDX3NGBOVJC/cOsbnN/HyaGNZcE4NiSdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504215; x=1795109015;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CPqL/jXjgacEff5dEPASqy6/Bbk+NnoKXgfKHY7JVag=;
        b=eVZ0hM7+XU7piUlNq/RH7BkktqQVX6Mgmo/3h0sZFtmYDCBKSv9rh9LhWzxnaUBpx9
         HbvSi2/o6W1U3LbgtoRW/CsQNuhKBkkQMK8S2dMO4gUWusauVQA7pVHo9KA7PH0vthld
         5ka//StFVgvfucv7eIUJ3xlkhPPu1sX56JWKFy6KnTAKYL+AgxZ4+NJYVjt8awbcT0L4
         IWrabq5/JmBT0vR8x7uXjHtQyY1HJrnc6j8GG8hbEN0ksVyI7s8p70SqBtcFPYbq1rs2
         csjXo9VcHHcmQjj8NfLGCGI9OJdL3jl5nHVp8xQzF1X9JLxFsh0uDTZlfU/MoTZJnhyh
         E4gA==
X-Forwarded-Encrypted: i=1; AL+hErG5tg+3fPwf2XIbrG1r9nrwX3guZlw7ZwqDVfh5rZqMZgmEfWOmpUA+6UR/qbKDYmFIDLbjUnMzAa8QL87uM20=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lAwg30FniZgeBa3w2C+bWesCzdUDlcNrf6tu8UqV0DZOqPYaO
	CW/aMm5aG4pJufiHEY7PpNq82guQheR7oVW0vK7IUo8SoCqwXIxC4tRyg+disEYKraUrxkcE9M8
	gjGjeuusKDA==
X-Gm-Gg: AYBFou1VgpE+ylzrjXe57hBAFJ9/IprDn6au4QkQHb+kRLvKgN5S0ifHET0lkhdpo4G
	31ESW6wvuPQWWLiqJD1nBs3Jm6TXczC8RbFholMDM3Mt53YRyQYfTx9A9DqJAbLWH8wFgF0wX7D
	4NWOpBQPjVRRXBuitfeYovH+XYaVc1eP3APoIAzV8tpEAE4Ijr09uzRV6+I3HGtFjXBZVyxhVFJ
	klOKiRG6LD7TxQLLdppuvC4e8cSo6E/8E4iX4JZ8pg8sf8YOnB4ivke89IvlMkdta+By92YaRrY
	rQfPo6z8oPaEIRUWd2W/deUEElbpRPz36UmP6GW3yWHmWWjls+8BwWQz+2CnOY4gfOW/Jt2+I+E
	SLRYlf19OOIXkxFgXuDMc/6amzkcSyyLkoeO+tw28khkp1WEI+ZqAlBsIX5ZGcc8j5koUpFusZ1
	MLCIsIn8MT8RWMrYECz84xP6rBOJaQmbeWq3Tuzw1E0eCY8pqnDlyWnVyBnRlrgHOQHYIKQtjLu
	wLzPdmbUW/PhPIAfslNBjqTB/P1yj0S0lUqZ4chy4zgr+5t4h3Y8gtQ1d8b1Q91zOomq7BZ96h2
	vnZmBhTETOGtHMRYPGhymAFcGVNifK3m/0/Tt0AAvC2fOzz0XaFvrLQFypKRDRlhy+mnrtktDY2
	sjQ==
X-Received: by 2002:a05:6402:2113:b0:6b5:962e:e00f with SMTP id 4fb4d7f45d1cf-6b7c0c6dbe3mr263237a12.28.1794504214741;
        Thu, 12 Nov 2026 09:23:34 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578d2caesm3736609a12.16.2026.11.12.09.23.34
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:23:34 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso684656866b.2
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 09:23:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGuRZscQZIIcKW3YnZpbYqMqmmRWtMwHeQsk6AqmCy5e3r5p7ciiVvhom94eb2H/TGK6TfuoHvOEV0zifD9D2o=@vger.kernel.org
X-Received: by 2002:a17:907:2d9e:b0:c50:4b7a:de71 with SMTP id
 a640c23a62f3a-c5066c973bfmr611766466b.28.1794504214466; Thu, 12 Nov 2026
 09:23:34 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260914223212.i.829-kees@kernel.org> <20260914223219.901347-2-kees@kernel.org>
 <20261112004039.GA523044@killaraus.ideasonboard.com> <avWNCC3_Ff0knO6J@devuan>
 <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com> <202611120905.DF88D9849@keescook>
In-Reply-To: <202611120905.DF88D9849@keescook>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 12 Nov 2026 09:23:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whAF3brA9Wrcf3KDhNn_653zhUsoqe1MSneYJWtS5505Q@mail.gmail.com>
X-Gm-Features: AclHuK_HNQpT4tCfX_FLYbv7PC35fGzeh8ZhM2vC9ghehMzLoLgyRTCdJiNaTCw
Message-ID: <CAHk-=whAF3brA9Wrcf3KDhNn_653zhUsoqe1MSneYJWtS5505Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for devm_kmalloc
To: Kees Cook <kees@kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, driver-core@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, justinstitt@google.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 09:09, Kees Cook <kees@kernel.org> wrote:
>
> One thing Justin was poking at was adding a "strict" mode to typedef

Honestly, the sparse setup is superior. It does that 'strict' thing
(except it calls it 'nocast') _and_ it has 'bitwise' that is a nocast
that also disallows non-bit type checks (which is *very* useful for
things like "this is a big-endian value: you can only do bitwise
checks against other big-endian values).

So the compiler addition may be worth it, but  even the "poking at" is
weaker than what sparse already does.

And the 'struct' model is honestly superior to both when it works -
but can add extra overhead (but can also end up being nicer than both:
instead of casting with special "I really mean it" casts, you can
derefence the struct and get its value that way)

              Linus
