Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA01DE2DD
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182209; cv=none; b=DgpPR9uiNHfElAr0RqN2R/hJLFjADkuxIIGB+NnuQndLgF0wFag8PktsjHi0pH2YdQLIutprC1TvY9A/3uqCxntoQ/z4P7PJcg1XQIXIKrbi3nJzLzdwNfZ5Q10O81Z6qYendq/wbr88ozdapb7Z2OE7rVIKrFJAk6WgcKShrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182209; c=relaxed/simple;
	bh=Jhe+8yYKduRf0fDdopfaFN3/xAHL1pUMnMf840H+3xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAZFO6A4CGl5lNjbZreBSFaTi+YkoEhczn4dX2oPwgtLclOIxGfvQpe7xM+P9JncCbcz6Tk31IKCFZhbajreXiZv6S+JsU6Kcka8DCV7T2lddo9wzKUeJmVEHoAze5j9x6aB12IU3q2Hd1p1BEd4lM028LQTDtVVXwFCYAhQMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjPFmGca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjPFmGca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35450C4CEC3;
	Thu, 17 Oct 2024 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729182209;
	bh=Jhe+8yYKduRf0fDdopfaFN3/xAHL1pUMnMf840H+3xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjPFmGcag2GLrPtLUuIpxiAoKW7jH2738mAKLSfuZZLFKUYECeuS/42OHMm9idhxY
	 HSkubQyT9yx7TxIAAP7xq/ONAp5M3lZNwDGnqexoY61Zr9vG9Q9us5hmViqnjPcZ7U
	 9QaT9iX7r1Oz4dUlolOyesofgK33t6HdqyR9q0PiKTcJCiCwSO2HcdS46ooroI+xsE
	 B68RCN47BXCmJyYW6aST+1Rjy3I5/3rrTiPLhso6bgFleIVZsQAb1dsESsrkYnyUOw
	 b6goRX9CNzXUQy2jN/W85iituKq3JbWkPVROfaBJMl5GW3YcnCMzZabMydyblS5BQJ
	 Nn76A401QLoYw==
Date: Thu, 17 Oct 2024 09:23:25 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: Fwd: [linux-next:master 4380/4439]
 include/linux/fortify-string.h:293:17: error: call to '__write_overflow'
 declared with attribute error: detected write beyond size of object (1st
 parameter)
Message-ID: <202410170922.0B55ABC@keescook>
References: <202410171420.1V00ICVG-lkp@intel.com>
 <CAHC9VhQasYp3dkv5Mx4uEy7ZmtYWywU2wJrto_xvUAjgScXL5w@mail.gmail.com>
 <202410170847.F6C111256F@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410170847.F6C111256F@keescook>

On Thu, Oct 17, 2024 at 09:07:13AM -0700, Kees Cook wrote:
> Something in the .config is causing the error. (!?) I will start a
> CONFIG bisect...

Well, I did a code bisect first, and it reported this which makes _no_
sense:
8afd8c8faa24 ("lsm: remove lsm_prop scaffolding")

O_o

-- 
Kees Cook
