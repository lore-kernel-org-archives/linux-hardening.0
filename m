Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E42153EA;
	Mon, 15 Jun 2026 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535523; cv=none; b=lsNEqkYQyvfaQMxr+KrAy9GtR+Zov0cPOzmECeOuhTYqPyWcfz/Om7BneGt7a8qdJJYlTTQZ9YOGRRXGZ2xJBxKWspOeZTN2K90E1AdnH9jqCbwtZGveCu4pZNgfc75nOUn0INbJJ33pGRLLZ71FDHtbDSUZ9e3/4xYkETV35Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535523; c=relaxed/simple;
	bh=gLobkqqLmgLevCDLJNxW6jVb9pHs+UE9NmjOS9c+o7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZbVCA+7xbznBFl8bDowz65dX8h9gYIWel3HdQQDYTDInjsRsFyc81YWXy9bLDguvmOgtu9ZH6Cy+KQqL4sppcFK7q+KoFhCmLAh6niM6ePwdYku5yVPRAPuMNwoDgJvTmdPyKg7/VY2goxoFSSVXk3i89A91pa8aZaT3jInWmNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PC0UCGGY; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PC0UCGGY"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7167040430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1781535515; bh=A/WCEYhquO1DFb2bk3Vy6AiRUGYQ1ZI5QBk77/Axasw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PC0UCGGYazcRyWfBP5Co4tRTwTmdqJ8vuqIhTozE4Zh82TCHQU7IUjcn7SWoP6Ft1
	 LzON+oNce4Y58oPO5M7OVk+pAVtYhSfwV3fHRsCr9T48hfT1OsAPZ0EN8TIRqIGRUl
	 j5ydivTr48FiqBC4tDDA+twyRH4MKi59AZENKvQRzEAoLD2s46UsRoed73uhjOQZoM
	 RETQgHJWddSNL9UlKW6I7L1zKIbG9K4siiqbUpTs2rXCpiO/yirpztHGFl3kT3HkUN
	 d/NR1zLp0pcRfloNpkXXm8pVPB0i27jC0Rf315jUSQC/NVhKI5sK8kFz5GCV4/A/Gv
	 7iOD0bkZPtdzA==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7167040430;
	Mon, 15 Jun 2026 14:58:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Dan Carpenter
 <error27@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Stefano Zacchiroli <zack@upsilon.cc>, Steven
 Rostedt <rostedt@goodmis.org>, Laura Abbott <labbott@kernel.org>, Julia
 Lawall <julia.lawall@inria.fr>, Wenwen Wang <wenwen@cs.uga.edu>, "Gustavo
 A . R . Silva" <gustavoars@kernel.org>, Thorsten Leemhuis
 <linux@leemhuis.info>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Dawei Feng
 <dawei.feng@seu.edu.cn>
Subject: Re: [PATCH v3] Documentation/process: Add Researcher Guidelines
In-Reply-To: <ajACprp9UJp2JSJM@black.igk.intel.com>
References: <20220304181418.1692016-1-keescook@chromium.org>
 <ahgaOigklcDCYvRp@stanley.mountain> <ajACprp9UJp2JSJM@black.igk.intel.com>
Date: Mon, 15 Jun 2026 08:58:34 -0600
Message-ID: <875x3j3l5x.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@intel.com> writes:

> On Thu, May 28, 2026 at 01:34:34PM +0300, Dan Carpenter wrote:
>> On Fri, Mar 04, 2022 at 10:14:18AM -0800, Kees Cook wrote:
>
> ...
>
>> > +  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
>> > +  11.2 show no new warnings, and LeakMagic no longer warns about this
>> > +  code path. As we don't have a FooBar device to test with, no runtime
>> > +  testing was able to be performed.
>> 
>> People have started sending commit messages in this exact template and
>> normally I would ask them resend with the meta commentary from this
>> paragraph below the --- cut off line.
>> 
>> Do we really want this "Compile tested only" stuff in the permanent git
>> log?
>
> +1 here, can we rather avoid flooding commit messages with the meta, that
> anyways is available in lore.kernel.org archives?

Perhaps somebody should send a patch correcting the wording to how they
think it should be...?

Thanks,

jon
