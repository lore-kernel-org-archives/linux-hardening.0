Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54177F08;
	Wed, 19 Jun 2024 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829241; cv=none; b=qQyMLkamVu/UJHcrD42jvRVzJUb3+oLkY9IS+1/mTab7vZhPPTjHak7dsA7hl9uiehra5NjQ8b411lfkoKaoG8ZBEnSOZTZj+SFdhx8p75kdusn4juxobDtvPm7aEmbsEgnigsw9NoG+l6HuzqNPa5DB43xglHaVXfBuJxW+nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829241; c=relaxed/simple;
	bh=UGJrd/dy7d9j7DieSTpj5tH7gE0lVERd5KxspsO/XvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbCsaokL6wt2w/wsJCFVCjYY2HRXrhXtIvLtV+VLddQ90KNSMdDuxqYWfxaV5TSy0WcegSiKkiXRRa8qRrQYMHYRnJ9FP2SE8cu7XTqYSQFdqmZY+NyRReaNGf2wNCM0z/MY80L+q687KI6AgIZEofT4dGzvjlGapoh9PZkfgC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrJjpt1V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrJjpt1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF9AC2BBFC;
	Wed, 19 Jun 2024 20:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829240;
	bh=UGJrd/dy7d9j7DieSTpj5tH7gE0lVERd5KxspsO/XvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrJjpt1V1+R8Nq7rfB2eb97Hbv+g9L2MGs4UcVMfo8a2vZieKPm6B7Bu6NkTLHBQn
	 93jrpnLEGmeBF1NrzBBlo5Lv1XELOFrt3rYky2QNl286rEc/OeNiVfbnGzgvDqxPEX
	 /4ie9lvhgeyao7xOpO8YKFNjin7s6oz2YBDcuVq3be/bHaVuPRC1y7SBQ+hv7y4VQ4
	 x4v9O3hmTdBmGYgtaYATpjRMfi/5Zpmy5r3WMpDW8zOjk2a/d3lxzvVUNpuJhK0/YO
	 aAMsaosd9wRgTgXz0AXUCvTbfqheLBEijt8PF37j23TjskrGClkmmxVekgOSGVdo0r
	 krQTm5Dgo8XKA==
Date: Wed, 19 Jun 2024 13:34:00 -0700
From: Kees Cook <kees@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/2] USB: serial: garmin_gps: annotate struct
 garmin_packet with __counted_by
Message-ID: <202406191333.8602549F2@keescook>
References: <20240619-garmin_gps_counted_by-v2-0-f82f10ebbf28@gmail.com>
 <20240619-garmin_gps_counted_by-v2-1-f82f10ebbf28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-garmin_gps_counted_by-v2-1-f82f10ebbf28@gmail.com>

On Wed, Jun 19, 2024 at 09:42:44PM +0200, Javier Carrasco wrote:
> Use the __counted_by compiler attribute for the data[] flexible array
> member to improve the results of array bound sanitizers.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
