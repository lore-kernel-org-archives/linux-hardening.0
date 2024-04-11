Received: from msa.smtpout.orange.fr (smtp-66.smtpout.orange.fr [80.12.242.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC513D544;
	Thu, 11 Apr 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872294; cv=none; b=Fmu5q10xKND6bjFqjXLBxqoDUG8dNiP1oP7I0M2YpT6miOqgPwEhCrAZxhXUVxKLEyJKhwqWWSuUdp93DM3oy2bbRu0e9VdlUKurqb0Cr3Ox/bzs3pC63o3d+wv2nqk7qlASTOpEVG2w+S5Hex7Dq6QqM1BWe7afw/xjxj3a0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872294; c=relaxed/simple;
	bh=AVclvdL6//c5Rcr+h+dJy4tgWHKepODdJXELWxA94E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnHi2ig4rUWjvjFJiwV1pwkSMF3zHA2Y8Qf4Gqq0EbIDK+/C4+O3VK/HKSUuTk4LepgG53cxlMacienVcp1hiyXww/7DkK7+BsHLdI5toQxkdcYFUUtn7xLJ4rKOqHK07VaIuQ1y9n4bitWfGsV5mrDi4eFIhYz3APfapsZo7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BtgfNEll; arc=none smtp.client-ip=80.12.242.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BtgfNEll"
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id v0c7r4ySyA2vSv0c7rijm1; Thu, 11 Apr 2024 22:01:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712865700;
	bh=DVVJHd+qbC3ifuZnV4XwadjAT7VtaXweCZnA1mXn8hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=BtgfNEllbSY5CLAf5rhYxFyA92jERCdt70gtxu6N4Gg5Ho7HLtj7f3BhdQJ9rD/lu
	 G34584g1aTgi2d9IcJWg/F8FUNGqpKQr3HYAMmHsq/xhxFSGS45Tq3T5+mmOzlZ3ff
	 kq20VkdmWOM47997evgwsvIJEsdefod9jQ8hkLvgL9pHwhB0OBI00SJ3TUceHEsXwY
	 BdwVf0M8TbozlPji+ihr/CA3Y6/nxp1/zIL3MMmFtNVmRSAhSh91si/zk1TpSlCPUR
	 rOSjzsJgQ9VrsJJtAH2P94MV/tPOByG9W+ZS4NJ9e0eXj8w0M8tSJObFNl+ht03B1s
	 gjj65t2ISmjzA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Apr 2024 22:01:40 +0200
X-ME-IP: 86.243.17.157
Message-ID: <48d593c1-c706-4af3-aacf-d1329a8b0d4b@wanadoo.fr>
Date: Thu, 11 Apr 2024 22:01:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] checkpatch: add check for snprintf to scnprintf
To: Justin Stitt <justinstitt@google.com>, Andy Whitcroft
 <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Finn Thain <fthain@linux-m68k.org>
References: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/04/2024 à 22:53, Justin Stitt a écrit :
> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
> 
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
> 
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
> 
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v4:
> - also check for vsnprintf variant (thanks Bill)
> - Link to v3: https://lore.kernel.org/r/20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com
> 
> Changes in v3:
> - fix indentation
> - add reference link (https://github.com/KSPP/linux/issues/105) (thanks Joe)
> - Link to v2: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com
> 
> Changes in v2:
> - Had a vim moment and deleted a character before sending the patch.
> - Replaced the character :)
> - Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com
> ---
>  From a discussion here [1].
> 
> [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org/
> ---
>   scripts/checkpatch.pl | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..a0fd681ea837 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7012,6 +7012,12 @@ sub process {
>   			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
>   		}
>   
> +# {v}snprintf uses that should likely be {v}scnprintf
> +		if ($line =~ /\b(v|)snprintf\s*\(\s*/) {

Hi,

for my understanding, what is the purpose of the 2nd "\s*"?
IMHO, it could be just removed.

> +			WARN("SNPRINTF",
> +			     "Prefer {v}scnprintf over {v}snprintf - see: https://github.com/KSPP/linux/issues/105\n" . $herecurr);

Maybe $1 instead of {v} in both places, so that is displays the real 
function name that is and should be used?

CJ

> +		}
> +
>   # ethtool_sprintf uses that should likely be ethtool_puts
>   		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
>   			if (WARN("PREFER_ETHTOOL_PUTS",
> 
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240221-snprintf-checkpatch-a864ed67ebd0
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 
> 

