Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA1198A17;
	Mon,  9 Mar 2026 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058366; cv=none; b=BBchczJNN8JWNv60q4fLtXRXRU8SGNvL7mvn7cm1lY6hb/p3aCZBNE2Vq23hprWlo7kdpKK5zemOKw22W0/1uuYOPyb9EXaBhCyJw8fFiUmGvHMGqFy1gBalPXdyeWDgXJhEzhz7P73Sp0P9zvwTLsSodb47MmLcpCw8mjp+Ol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058366; c=relaxed/simple;
	bh=1Tcki6VKO82QeDNN/6Ln1MgIAkRnNY7OOgxREDS2lg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zd6PzapdHyKzfR7apUnlS/hDgcJ91dmPoQupMzP4egXSo1BFG7HPaOe6ccQAhw6fr752nOhoBNN8laDodZx8o54pxLm9Q13i/mzp6j4G9oGmKCf5Ynnr6d6Ai5dbnGWI9FOJxye/7ErjgU2MJHRoU7DIlkEvfGn9jdFACL+gFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQJ4jIM/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQJ4jIM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17205C4CEF7;
	Mon,  9 Mar 2026 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773058365;
	bh=1Tcki6VKO82QeDNN/6Ln1MgIAkRnNY7OOgxREDS2lg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQJ4jIM/gXouzeG/XPSB18gYyBzFVUAKEFCSA3dKUunXusUUdJR4ookUG4aBGvpYS
	 xcA/kZFYTDfyqhzntohONv3HgXUMPaFZ7SvhpaNKvs5yPWk3rUNiTR79Da2z+hwCeP
	 GshAqMdQXBjzbmTEPsq40HtUs8MulIAXX0MRlemGQ/bXnPwBVn7TCimq1xL/rZV+DM
	 RdYL4RRcfHAbi3vlttBVeEc8nSLcXoBrGFjfEswRP1dTeb9VG7dTSAQ/eyM05THc6r
	 43T4o6a5cxB2p7kPlIGjLgT32CGEYG5VfVhbLzicfUE5G9261XcIzmmRapxAhpwzN9
	 F3pujEn+avESA==
Date: Mon, 9 Mar 2026 12:12:40 +0000
From: Simon Horman <horms@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: sched: cls_u32: Avoid memcpy()
 false-positive warning in u32_init_knode()
Message-ID: <20260309121240.GH461701@kernel.org>
References: <20260305073343.250702-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305073343.250702-1-jiayuan.chen@linux.dev>

On Thu, Mar 05, 2026 at 03:33:43PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Syzbot reported a warning in u32_init_knode() [1].
> 
> Similar to commit 7cba18332e36 ("net: sched: cls_u32: Avoid memcpy()
> false-positive warning") which addressed the same issue in u32_change(),
> use unsafe_memcpy() in u32_init_knode() to work around the compiler's
> inability to see into composite flexible array structs.
> 
> This silences the false-positive reported by syzbot:
> 
>   memcpy: detected field-spanning write (size 32) of single field
>   "&new->sel" at net/sched/cls_u32.c:855 (size 16)
> 
> Since the memory is correctly allocated with kzalloc_flex() using
> s->nkeys, this is purely a false positive and does not need a Fixes tag.
> 
> [1] https://syzkaller.appspot.com/bug?extid=d5ace703ed883df56e42
> 
> Reported-by: syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69a811b9.a70a0220.b118c.0019.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Made-with: Cursor

FWIIW, Made-with is a new tag to me, I would have expected Assisted-by.

That notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

