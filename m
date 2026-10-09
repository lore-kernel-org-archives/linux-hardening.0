Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D20498930;
	Fri,  9 Oct 2026 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547512; cv=none; b=YVA3FBkwG9gI/DdbExB4kCYZ9EHbOAtzS/erpYWAczS3EkDozakTebjehcEIFCQdU3yH9YGgCEasVuxcYp1LM03pP+lnLEYs+e3Imwb8KVzfdxbWTDq131+7ICE2xKIXjoxk474rV1z5V06RbiY6k9Nw/Pjb2TQnLROl3QCtz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547512; c=relaxed/simple;
	bh=dDqcPe0rLK4PbarGHkOkE7O3+8XMjQ0lPdGj6+4L48o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsVljxzQ38NRX2dE1aXPzuw8cE4o3UDVNYViiLEYE1VUNYVVlhS2rMXh6fk/6woI/h1QChQWbuJQTxAVNrtdXjqwYhmPzwZacqAitye+J+Qzo+b3etqhWriYT/+QBS6gh3s2trTZ7Oy8QMVgVg5KigRubuWQ74kmjQ72QagOvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbpdfxQ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbpdfxQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5401F00893;
	Fri,  9 Oct 2026 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547505;
	bh=pVMI5xWcSua40R4bqP5clZQ5B96uJET8HzpYwiIlDbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AbpdfxQ0K26rRRuXuSJzxqr/e8zU58GHh316KdkMj7ezMxUKEJrLZtOK//OhZBN7N
	 6qdLzVYyH0x7urYEA3mXNucPHi1GD0aurNrmtETo+orHJxfzJQ0YVYBkFqlRFqFQfg
	 N6sMuTgQjTe7PJrv2+IzJLKWZ3z7pmM7Q78/bHk7ghi6QL+0vU/1CgVZ/+/qmYsT92
	 oBZu+IKXs0U0egpxrnFGd/VHFdslnMAIHxKbQeY1EC9EYWu9cFEmZ1TpkwPxUeJs1f
	 f79BgikHH6gWRBqDisr2LNcpg63RxSPlMjlIf++EZ3s7GjJCZBvGayEz4m3tAj7SN8
	 lHnCHCwS3ItwA==
Date: Fri, 9 Oct 2026 13:05:00 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Manuel Ebner <manuelebnerli@mailbox.org>, linux-kbuild@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/2] kbuild: Mark the kernel image gzip recipes as
 recursive
Message-ID: <asjYDiBaS1V5CymE@gremlin>
References: <20261009062722.i.253-kees@kernel.org>
 <20261009062733.3119731-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009062733.3119731-1-kees@kernel.org>

On Thu, Oct 08, 2026 at 11:27:30PM -0700, Kees Cook wrote:
> Since commit 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if
> available"), cmd_gzip runs pigz through scripts/jobserver-exec, which
> takes the job slots make has free. GNU Make passes the jobserver pipe
> only to recipes it treats as recursive, but leaves --jobserver-auth in
> MAKEFLAGS for all of them. The make 4.3 in CentOS Stream 9 also hides
> the pipe in sub-makes (a backport of the fix for GNU Make bug 58232), so
> jobserver-exec cannot open it, runs pigz on one thread, and prints:
>
>   WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')
>
> Mark the gzip recipes as recursive with "+", as commit ecab4115c44cc
> ("kbuild: mark `rustc` (and others) invocations as recursive") did for
> rustc. As with those, "make -n" now runs them.
>
> Tested ARCH=x86_64 and ARCH=arm64 defconfig with GNU Make 4.3 plus
> CentOS Stream 9's make-4.3-cloexec.patch, GCC 16.2.0, and -j64: without
> this change the warning appears and pigz runs with "-p 1"; with it there
> is no warning, and pigz runs with "-p 54" and "-p 64".
>
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Closes: https://lore.kernel.org/all/0ddb5e5e-f801-444c-aa98-0cfe814a3026@paulmck-laptop/
> Fixes: 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if available")
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>

Nice find!

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sorry for breaking your build Paul ;)

--
Cheers, Lorenzo
