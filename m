Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB58F75;
	Fri, 27 Oct 2023 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djguQmPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FB8C433C7;
	Fri, 27 Oct 2023 07:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698390538;
	bh=5WPvMZXHj6SnWHKzmjOCyWmBTsevR5RWBT42u2tYT6Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=djguQmPRxLNmjYP9HHUj67/uEd0zfx8KeWVkiz51AIIpYw2lVH8qW0B0MfbRpUIje
	 pLMOnDUaSzl386rS4fNWyfCgOeKql4iaRefnSH/kI+FVAQpkkZCMg8hov4dFdILjul
	 dR3cUtJP2hF2h42zhQlsXvQCJhrobipu1HPqu90ilKmuDpqKFMemvGiECLBlxdyaBC
	 T6N1ZSbC2tYoRhhYmIbdtxYWULzyhqeqkzZzN46peCq7r9cGKFs3j2UaIgQ60dIlPg
	 Gjn4IcKGoXoNZoHAyQJZfHbpDDcCtF60mGs4pQROGMlEwgaN1hFfZsBxI5KZa9cEJg
	 2/5rGVP9O4Rfg==
From: Kalle Valo <kvalo@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,  James Bottomley
 <James.Bottomley@HansenPartnership.com>,  Christoph Hellwig <hch@lst.de>,
  Kees Cook <keescook@chromium.org>,  Justin Stitt
 <justinstitt@google.com>,  Keith Busch <kbusch@kernel.org>,  Jens Axboe
 <axboe@kernel.dk>,  Sagi Grimberg <sagi@grimberg.me>,
  linux-nvme@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-hardening@vger.kernel.org,  ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
	<20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
	<20231020044645.GC11984@lst.de>
	<CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
	<202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
	<710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
	<20231026095235.760f5546@gandalf.local.home>
	<874jid8one.fsf@meer.lwn.net>
Date: Fri, 27 Oct 2023 10:08:53 +0300
In-Reply-To: <874jid8one.fsf@meer.lwn.net> (Jonathan Corbet's message of "Thu,
	26 Oct 2023 08:05:41 -0600")
Message-ID: <87bkckczju.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> Steven Rostedt <rostedt@goodmis.org> writes:
>
>> On Thu, 26 Oct 2023 07:39:44 -0400
>> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>>
>>> While it's nice in theory to have everything documented, it's not much
>>> use if no one can actually find the information ...
>>
>> Does kerneldoc provide an automated index?
>
> If you go to https://www.kernel.org/doc/html/latest/

BTW there's now a shorter URL for this whic is really nice:

https://docs.kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
