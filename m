Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F1182BD;
	Sat,  8 Mar 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741461034; cv=none; b=YoESdMcLPY5CIYSsQBpegAk+c5Y/TBr6kvG0Qowh1p7V1LaPfFYTycIXQAzQKUuhAWUBtOWgtIA0v8j14f053t7JcanxbG00vh/xxDwaC6zwZxNJbvENOBMzDnzBhCmNisLbptS5FmyYotO45lYyXIijyv9cbXhhjkyQ5tya1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741461034; c=relaxed/simple;
	bh=MFhWjnwCq9VAZ1ofWC8aiiD17UJ5XlmzNLHT6UJtbaI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=r2qp60O4yhkbLRU4jjEkSEhtNcsyHkqBs5Vf23YmKZfWRXU42M/jdvWr93wcmh7V73fkOrW5CeniTQnHosq7/UhSY1LF6V7DRw73HCIEuGpLthpZ167clevfsLfYBFNoORGqukpzFUj6HOCkY2/DCKwO3fzfIhkkd0Gz1/75Na8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GZ9fVXSh; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GZ9fVXSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741461011; x=1742065811; i=markus.elfring@web.de;
	bh=MFhWjnwCq9VAZ1ofWC8aiiD17UJ5XlmzNLHT6UJtbaI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GZ9fVXShcYPk36YjF/USdyCj+HqQr4HPRMvWhpgh9xylo123bKqShlbxZXrNT7Km
	 1DK8uLkhHaVu5q/forUQc57zNUgVMunq1uluXKpG9kJZ7LT9ef+qtXBsyDqNM9DFF
	 OGlbI8FzNprEn5/6AlIfAfcdqKzL0/DPxobF7vNEgQ2DicjK4tcEbO+l5uCLxYx6i
	 CJuvhNR9cMVc1uqXVfEA+nUlLyQ7GUwlt1ea944vMvCajLra8mC91p1IgmcORpeE5
	 OwKH8mmzEpzeE7LOpx/9yy/4zqT0uNvptaUMVx5hq4oDBMzRYd0x/ODCBnf2VCYFv
	 GdDN4boGXacaYkTyNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.79]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWzCt-1tklNy1ezR-00YcVT; Sat, 08
 Mar 2025 20:10:11 +0100
Message-ID: <61137c75-1b24-4425-bed8-518e1bfb0e0d@web.de>
Date: Sat, 8 Mar 2025 20:10:10 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
 linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20250308-ctdaio-kzalloc-v1-1-804a09875b0e@ethancedwards.com>
Subject: Re: [PATCH] ALSA: ctxfi: change dao_set_input functions from kzalloc
 to kcalloc
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250308-ctdaio-kzalloc-v1-1-804a09875b0e@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dsp8DBc0wP5H3VzZJi1LMWqnO101NZOaF6ZxuUTZpY1kn7sddfe
 hTtY6fvvqnf2WwfRyZpwRVjvrFHCKH7TuI7tzxciBQhYp71Iz88Md+WNor/O0OCRnICmap2
 d+RKhjHEs45pOtRmgBBjmv2rpgLaL9WGYHIG8lM1MFa0YDdzaIpsXcmcVdVRMLYnYQN71S7
 1ooSS6xxo5Co0w7uJNf9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F0IpBO66jtY=;+ffitv7G7GsrvY+Ptl1hdlzG4VM
 tNJOcLiEGykBDZSP7RmjKyrWZoHMGGRRvsZJik/k09qX8nRAeVBCEXrEQT2/KvJOm9sjiRVDn
 JtG09aAYby24JyywHzDCJnWGu3YD286W4FCK9wofsyEALq44GHAs3FC+9VL4nEQNDB51JTbIZ
 G1AHikl7WuDHiZfU8uV1JlJc0qE0JDRq1ogH1yIbC1tzNyVyjObuAIVSTL/ljDzYVs6Qz0bNd
 rv6tmV+GHuyRYS0DEI5Vk7yfLFOzIDqVEX+Ol1VbRGx1owWTywJVbkLwPMH20ODkkiBrHsJW4
 b3eq0bnYPw7u5Td/IHYa9qZHYc0svZVffba1PK2KyCxA2xjaLhfiQq//p72faVHemASG+srxb
 cAi28hYlAGIWu/y9U3AOgiDTbLruPjmkL24SUcL/kKxdrcESLt+Wasi+aTnKlePkcO6qtx4dw
 ZZp7I82lNAsmAO7vkjmGqoCbHvxcpwLJ25Wz36oYr0OQlXeSIZ3yNO8i5Mq0qGNOKIG1SFpXe
 ExBNJuDaU8SNc1Fafj2FDLQH6SY8NpLuQF3GUZO1srIwgFzEcalqKNdzY+1cm0jDYFnGKVvC9
 7BpFCqib4vriRzieqOuctKBtkLSvGHsfjymD5gHELoW1VsRN65mEA8gO3m8Cg7cpalGEHP7hh
 Ij/mBn+sjis0HVfnuZYC41QZCkSgQSg4DdX7mcBdtdQU8254Rhrkyqqxs6R9jHQx8RLiqujMb
 ktv2FLcSNR0Nc/Wjp3IcGn4cuMV6acIJ6kZXcZFIllLpm/AfDUCABf4mTUIrBV3Wplmzvmi4l
 4geD5D2w9Oskm8KrGpr2fQyHxyl1Q5EOXbaw+lu7M4tOecxrx/vhfIKIpB6+EsIx7bTyX/4uR
 aHbumsiIPp33d9LfDdpm5kbtJcN45exv94FB+eI1XJHwh0w8j1+nR8KbkexwqIQ4YigsTa2kU
 z16ycaguEnKTbVn09nqAFZyRU3Y53vagfHnVXW41G9dsqQ4oYDlvQfsIGXYX661oe2um/e7hm
 1TfQLnx2EiV71VB/hbtJ0xFwcqX68W2ptVLUq+JVXeGGw9cGXuX3hAzG+1qW3YwmlRHBLWT/c
 bgRR6+CYwDraEvQC6rqghmfAKQLB/dcmHFQz7ybpQVBqH6GlbYeoowXDf6xNMRFcNU7rOpt5R
 8uR8IuIsTfWJGbV8jYd3tRdPj1QROVufupukT+WkSSXWB5dWpkfJbaT71T6AfH5L1prk3opYk
 wtRy9E9k800PjVvG/qx0To99y+81tETFTBF09i8X4HpGiZQY5dVCx7cOZS4R6KPSKP3TzPEQN
 CZMFeuqoqwuLkNzj2QozwsmjbiSeaIYPQGfhpjVMV1QdJ/l3ldu03D5LTYqJtrWvqZd2bbB9i
 YQKyIVpN/vv5hOonbBEik0mumeHSnPXaqdJ7REW8iJ+xaFKthg3X1dyeGNKDCJyhcNPHjX61F
 JAML5Z78WVw3tQVSHe9yY69Jb334=

> We are trying to get rid of all multiplications from allocation
=E2=80=A6

Please improve such a change description another bit.

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc5#n94

Regards,
Markus
