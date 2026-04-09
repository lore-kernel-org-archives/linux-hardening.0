Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246C26FA5A;
	Thu,  9 Apr 2026 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775776955; cv=none; b=B/cUuf0cOhuFKtfkvmDkDMJsWaWMgWUWtsrqMoV+hSXOY+b33skhYQjdZuOiw0shf9B52CwOX+4Sb4p/my0X9IHWHTPqRF3St1MnMse2iFqoO6wtE1PIoKY4d4nKQFniTjnAhI+5qKMiVysTpjzDSbXeuLrnjLzjZKptq66F3KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775776955; c=relaxed/simple;
	bh=F/kb+h9jHzZ9HxLjt+vGzWqzzwCyExO/qnVVtOJ8hJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6ocbtpLEuEGqYIdl49c7mcZZ0/P2a69OREdSEEkFOER/2BzeQao46s99ANtI4iIKKbntUehGBTgmVhoTb+ByL3cxgaWdVW68b2ACy04z47QSt1uA+b9G3zzHwmM7P460vHC8n/44micgZHpd074hkv6tU0Wo2ilbhFC47676oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHvNu3VH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHvNu3VH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742BEC4CEF7;
	Thu,  9 Apr 2026 23:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775776954;
	bh=F/kb+h9jHzZ9HxLjt+vGzWqzzwCyExO/qnVVtOJ8hJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHvNu3VH0CyYc3I9ZwUx2gVphIBieaJusoal+mErKbxPVLQ4QVpbvgc2WPL9yZgWv
	 9YWf/G8F0G4yd9l4nWj8ZNWrEF8iKpZKEKNW8c1+k9xRSCByXqRbpONJ0K35Yry/zZ
	 +yyjIRu6O0YR4KZnFe/HAfrvql8vybUv3lOjSnS9lzY+KFjKw07hvwg0Rgv/12pwPs
	 0PkTd+RVWlWr8/u79p7ainU+2sp3eK3Y5PvatdcwebCxiBlBx9pUCUGoxcjGZqrC90
	 OffJkUZGxK3JmmEFA04aTpU9CCKP+MOIjSToBjakprBnQr6nh1tpB1v6lfQriweZdF
	 7EJIIOQJZT8PQ==
Date: Fri, 10 Apr 2026 01:22:31 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-i2c@vger.kernel.org, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
Message-ID: <adg0kP1OZDbnUaQZ@zenone.zhora.eu>
References: <20260327030310.8502-1-rosenp@gmail.com>
 <adfTdfty7q0nygeo@zenone.zhora.eu>
 <CAKxU2N9tkjDeE6Zz6diMEMT4uNzYg4D36gow0BTbaC=AyAeT3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N9tkjDeE6Zz6diMEMT4uNzYg4D36gow0BTbaC=AyAeT3A@mail.gmail.com>

Hi Rosen,

> > > -     alias_pool = kzalloc_obj(*alias_pool);
> > > +     alias_pool = kzalloc_flex(*alias_pool, aliases, num_aliases);
> > >       if (!alias_pool)
> > >               return ERR_PTR(-ENOMEM);
> > >
> > >       alias_pool->size = num_aliases;
> >
> > this line is not needed anymore because kzalloc_flex will resolve
> > to alias_pool size and will set it tu num_aliases.
> I believe that only works with GCC15 and above.

Yes, you're right, it works with clang.

Merged to i2c/i2c-host.

Thanks,
Andi
