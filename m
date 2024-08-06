Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8AB663
	for <linux-hardening@vger.kernel.org>; Tue,  6 Aug 2024 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919234; cv=none; b=TlFOmxVcDCkr7Wwic2LGYGwvS9AtKRUBQ7hnUQ+4Jsd6oP8mCChOntcDTr8IMzAla5KiStV4dLqQOgMNGljsoNhXBNMfSQkZ+LoqMi4tmwefW0R5BQVfjQ6i61fIxFXClbG65Ewl+kIxxWhMBIrgOB3YNwVS2qSup9uJi1wZCAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919234; c=relaxed/simple;
	bh=TGrrBeDL7B99XiCbosmyQ0mymwhzZjVNoqelRrg7mqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOP/7G9TzRMyWXu00HMOWgDUH96FKdbkRQvz2v0lXVX/aa4t6Pp2SMc+csov6SJ88Uzm+rMYl/o0uuAhe9FTkV2YB2xn43RJbC3o6toLGeDE4PGt4gF6gbeDzmv15VlzjOxY86ia2A+v8XHX84UOtQAQrp1LTM+i/YJ3Z7QOQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfGFIp4v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfGFIp4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5825AC32786;
	Tue,  6 Aug 2024 04:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722919233;
	bh=TGrrBeDL7B99XiCbosmyQ0mymwhzZjVNoqelRrg7mqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfGFIp4v1BMPMhd/jMqMB4HX4kf9Vn0ZEOnZ9A47O1c+XDwm71sOCPD+nGTKQTOOC
	 Ob6vlU9vWICzcnjdTXrz8QAjD511srhxW3TqneMVQZmGXhJzqdAx6lFb6XpIV4Nf0w
	 vu0NUKzoUEuBnTc+O1vohSAQ5JNnJ2m1Hhr9CA6g8CUM+a6B04AZGHf5dXw+TYkd8u
	 EqaR8xRq3h7Diy4Q3N2r/SsZhCM5hGJkFWEF4zDzlk/O4o5R/6C7uxwvotETFuiSqr
	 H8sv4VLKz3XrowV2Y/rKOEBxzyjqw0CcDHvfj3rXw5cTAwgNWHVhOffc7igFc8R9aZ
	 UuaCoI8TgAf7w==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org,
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] lib/string_choices: Add str_up_down() helper
Date: Mon,  5 Aug 2024 21:40:29 -0700
Message-Id: <172291922667.3394747.15128176990072940888.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725101841.574-1-michal.wajdeczko@intel.com>
References: <20240725101841.574-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 25 Jul 2024 12:18:40 +0200, Michal Wajdeczko wrote:
> Add str_up_down() helper to return "up" or "down" string literal.
> 
> 

Applied to for-next/hardening, thanks!

[1/2] lib/string_choices: Add str_up_down() helper
      https://git.kernel.org/kees/c/3ff37dbb1ae9
[2/2] coccinelle: Add rules to find str_up_down() replacements
      https://git.kernel.org/kees/c/d518b5f7f2d5

Take care,

-- 
Kees Cook

