Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C313A40C;
	Sat, 28 Sep 2024 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727560267; cv=none; b=GIhO3IgZYfKE1Pkk27yPDLD0EEqihWKDurk5ZeOFX6Wpypd6fdw5aiUz7pw51Huxeg6LezwE6f3ZDFOfr6EfNlNiBUvWJ9VwpE3lxPgPqAJSUzQarLf5GNdApfYv+yCweKKbmOE87QwnEFFZBF+6F+1w+juCnpU8mWFJBMheO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727560267; c=relaxed/simple;
	bh=Ieu/6NBrjDmKc+A6Qg2WBZVQaHkRzHU5QOcz9DyXwJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIGah8eRcT12HIL2DIgrqkV1I0dY6sxJSIBP9hIjfUGqbJUuZqJQQODOCAft86qCtgfU05zIHHYVEMXSCyRRF2WS9MKy3RuH4JJ3wLnaF32+vzpzWevnGY39WfKYMRw8Zvk2SFwBoDU6QwPXITS4IXPF18aN/bVZJcN0T+S03Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4tI913n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4tI913n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABF3C4CEC3;
	Sat, 28 Sep 2024 21:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727560266;
	bh=Ieu/6NBrjDmKc+A6Qg2WBZVQaHkRzHU5QOcz9DyXwJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4tI913nkPwTsnIeECD78nRW6tqHiRHJEgCzoFI8GWF7K+LIJ9tjF8MBAr8xvQ+kj
	 Eymlpgo1BHjzRmSuod/TKN+p9ajG2OJ2ceWpBA1E9HTZjBqi2QxKb1y/oYD4sb2BtP
	 1ne/hBpgB40VgIMpd6Qg1L8lIIGyAnHPugTWXHxqr9QTpkWMUSCK1Y8wzLnWnHLgK/
	 fqxmsUsg9OvRx/sHWoBxSjIqVAbUVA2XcMGc52jNyMIqmhP7IVP+duCPVmrw7oldNd
	 G2WVgCXkaSRKdiEV2kW2vEiMMZ0fl4ZgwtT3JW4Rdzbc7iKMko8FEMxbCimf9Fb/aN
	 HnVvrFh/YZdNg==
Date: Sat, 28 Sep 2024 14:51:06 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Allen Pais <apais@linux.microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Vijay Nag <nagvijay@microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] coredump: Do not lock during 'comm' reporting
Message-ID: <202409281449.B228D0C1E7@keescook>
References: <20240928210830.work.307-kees@kernel.org>
 <20240928143532.39559729f9eceee468358abe@linux-foundation.org>
 <202409281438.EAC4B88C@keescook>
 <20240928144636.d1964e6c6bb77c3e9123fc64@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928144636.d1964e6c6bb77c3e9123fc64@linux-foundation.org>

On Sat, Sep 28, 2024 at 02:46:36PM -0700, Andrew Morton wrote:
> On Sat, 28 Sep 2024 14:39:45 -0700 Kees Cook <kees@kernel.org> wrote:
> 
> > On Sat, Sep 28, 2024 at 02:35:32PM -0700, Andrew Morton wrote:
> > > On Sat, 28 Sep 2024 14:08:31 -0700 Kees Cook <kees@kernel.org> wrote:
> > > 
> > > > The 'comm' member will always be NUL terminated,
> > > 
> > > Why is this?  I thought this is only true if the caller holds task_lock()?
> > 
> > Because it's always written with strscpy_pad(). The final byte will
> > always be NUL. (And this has been true for a very long time.)
> 
> So why does __get_task_comm() need to take task_lock()?

That was to make sure we didn't end up with garbled results, but
discussions have determined that we don't care:
https://lore.kernel.org/all/20240828030321.20688-1-laoar.shao@gmail.com/

But just for safety's sake, I'll change this memcpy to:

    memcpy_and_pad(comm, sizeof(comm), current->comm, sizeof(comm) - 1, 0);

-- 
Kees Cook
