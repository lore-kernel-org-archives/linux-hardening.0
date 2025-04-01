Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CDC1EDA11;
	Tue,  1 Apr 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502672; cv=none; b=uEBXwxDhMsRT5EYk4oIojJV244SEWVNR+ZNhmZ88yIj9BdLavcS5Bs5i9/l1SfTmRdz/PGLYBP5gcgMNJukjieZsRNz197V8+9XM2XfAlVs6j6B0taucUsqoHpldQsib5BjDwYpnNw4dGc6dAJjC1sdPfJyr4jS33mFm3T1/+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502672; c=relaxed/simple;
	bh=RsW3xw6+4WGi3+qk80YDknYAreyWrpPOP0x0XNLeK8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOJSelVFRvDRsay7gBIch6e8yzxTVIkjXWOTXvQihtMa5iK1GimSi6CpGs+b4GuSj+8x1n0mTmlE6zxG4Y2AKlvNBy/dw+8fNA7jvI42WI92Z1jteNheOzA7lVs46VjkM767KOrA88xiP3bRNQELJx/mKGwJ3tJFL1XOz//Nprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbmIHGKl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbmIHGKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5AEC4CEE4;
	Tue,  1 Apr 2025 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743502671;
	bh=RsW3xw6+4WGi3+qk80YDknYAreyWrpPOP0x0XNLeK8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KbmIHGKlSG7568PngKnyT47oKbCKO6OArfI5MguoBHylG22sNyQoMi+ivtS1VEKqm
	 eQJoBFREUCVqxYgRXT+EuSwvcbrPW53H+FfnBRFhnej6mG0gnn2dw3Xie2HQmfExWc
	 1cM8ojiw+8LnBCxlasrQ2yPaObOp8JjGcKVogDXVcuV1AlCsnDlg9gjuQ0NxL3vDKm
	 xdUJMp7HHwbjrT6AXY8BmeQvd8WAQcttc6E4LuRQLqJITO3XKRNscWPFO0IRxFOs+a
	 Q9Z2kUBXkyNLFRKe3KlnQOkD20Lj3mNy2hEHeOAUSVAL/8HjBB4f+RptrEEv35HduE
	 M+5QliTUnOtwA==
Date: Tue, 1 Apr 2025 10:17:48 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: cros_ec: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-u9TNrnEGD8fM8V@google.com>
References: <Z-apE0ZmckBjRDyx@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-apE0ZmckBjRDyx@kspp>

On Fri, Mar 28, 2025 at 07:50:11AM -0600, Gustavo A. R. Silva wrote:
> +union cros_ec_sleep_data {
> +	struct ec_params_host_sleep_event req0;
> +	struct ec_params_host_sleep_event_v1 req1;
> +	struct ec_response_host_sleep_event_v1 resp1;
> +} __packed;

The __packed modifier seems redundant.

>  static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>  {
>  	int ret;
> -	struct {
> -		struct cros_ec_command msg;
> -		union {
> -			struct ec_params_host_sleep_event req0;
> -			struct ec_params_host_sleep_event_v1 req1;
> -			struct ec_response_host_sleep_event_v1 resp1;
> -		} u;
> -	} __packed buf;
> +	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
> +			sizeof(union cros_ec_sleep_data));

Is it possible to use something similar to:

MAX(MAX(sizeof(A), sizeof(B)),
    sizeof(C))

so that the union doesn't need to be defined?
