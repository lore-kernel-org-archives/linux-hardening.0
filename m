Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FFA1079C;
	Mon, 25 Sep 2023 07:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D16FC433C8;
	Mon, 25 Sep 2023 07:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695625412;
	bh=bmAGW7IJt2ztTo1zPNp1/mpQS4/bkBknIARLsF7U394=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DMVQlaEf67tOHftNFThuKdXgyAdtD0mbBEB7T2XUg9CW8RtZ+qst2VlYRKN+qAAqJ
	 76PIUfdXIBbH/l/TIrP2QcdDHXCp0kEZA8gk4qUGnMi6gq/OOcHZDqy1PQYyFDbl2V
	 ZqXsSIcDeaKBdRFnbHWxvsOvjwMsQktd5Nm+o9AIudLwKUTSmr5e/FFI5uUthLQIaP
	 oe9waQLEXCWd5t/rbEiTcIBTEMHZxxj1YyIAWrw+4yQfGa1MDbxhO4QoB7uSfWLaaY
	 mTqKUE+uCmO9DJxkRA8pyn5QH0F8g5abc+2wpDgp6TbUPZftUrry5rzIgbqd/fPwug
	 VThTcFwX2JDww==
Message-ID: <0981d982-45db-d069-e26b-801b67ad1ae3@kernel.org>
Date: Mon, 25 Sep 2023 09:03:29 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] libata: Annotate struct ata_cpr_log with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: linux-ide@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20230922175210.work.239-kees@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230922175210.work.239-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/09/22 19:52, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ata_cpr_log.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to for-6.7. Thanks !

-- 
Damien Le Moal
Western Digital Research

