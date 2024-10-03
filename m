Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344E1A4E8C;
	Thu,  3 Oct 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982546; cv=none; b=N0kTt5SztW2JdKAIsTVuGp7pzQhuqyr8xE51UHc9Vk3vnspzZO2RQ55dU80eDuesqu+Mk+Yi64c6b/EJrb6YlYKhWU1YUfZ0INaB3jakfjHFG5Fbe++hXrHRVFXRSyts1DD9GVZmi0Av0KziW5OBlG1Zerb99fbyJktZuIIsbnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982546; c=relaxed/simple;
	bh=A1mk0jpO/HJnFIGMhh2gBHVnCw9aebL7CYqdU1X6hUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU6CFKIrgmfyncjS9puAqzbhOGrLBM/SaxuKM4TZsQWXRY5xDPwOAtklp/T7VSxUX6eo8rh6pwosEQFgmw2CIbsWkb+6Jjm9UiYDhCBh7ZZQG8H0hEqQdgh7Ny0+x0IE0Mp0ylvbERjsuYmlovlYjIP+g91tL5qkjcf2vMvJpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZbyYNRi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZbyYNRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397E3C4CEC5;
	Thu,  3 Oct 2024 19:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727982546;
	bh=A1mk0jpO/HJnFIGMhh2gBHVnCw9aebL7CYqdU1X6hUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VZbyYNRi1lCjV8blElcJnTdLnmfLBhbJsJSoklWSGdL+QYNm5c+S3tEiJNrz8ArAw
	 xO5kQx9pnEMbsTfI2QP4m/mUzpFeWykvl195M3G0g4IUakSvZDCuEeOsOS6c2DYtb3
	 7NGdR9Smj/2tQ8wb6LvermzG1+iSjJMMsXNL1FWB1Ek+UD45GGgbufxzKA59enfDxP
	 N6+6Sd1brk9wH3EfYW4EmLP0Wsr0geK+vcNxDK4ftGp23HhpvN0zAelGktAqBanSSH
	 KQ3qh60kICSftkZQ/0Dwv2xvwuyEkoaroYusMOUqjP7V8ymA5UGb2R3e6a4QpIeupZ
	 oiwNNchrhcgQw==
Message-ID: <e9a05386-54d8-4a18-8b16-4e871de094a4@kernel.org>
Date: Thu, 3 Oct 2024 21:09:02 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZsZLFS1CsHkKjw+C@elsanto>
 <ef5a8e6d-cb97-4872-901c-cf4bbec23be6@embeddedor.com>
 <30530165-0ea9-4f02-9d8c-e8abc9eda5a7@kernel.org>
 <035ae74b-5df5-493f-9835-02c1c30ccfcc@kernel.org>
 <45560975-7215-4205-8d3b-a01009c9b4f5@embeddedor.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <45560975-7215-4205-8d3b-a01009c9b4f5@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/24 8:44 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 03/10/24 12:36, Danilo Krummrich wrote:
>> On 9/13/24 12:23 PM, Danilo Krummrich wrote:
>>> Hi,
>>>
>>> On 9/13/24 10:09 AM, Gustavo A. R. Silva wrote:
>>>> Hi all,
>>>>
>>>> Friendly ping: who can take this, please? 🙂
>>>
>>> Usually, that's me. But I thought you might want to send a v2 based on Kees'
>>> comments?
>>
>> Do you plan to follow up on this? I'd prefer if we could get rid of the open-
>> coded "17". So, maybe just go with the define until we have something like
>> STACK_FLEX_COUNT()?
> 
> Do you mean the following define...?>
> nv50_hdmi_enable(...)
> {
> ...
> #define data_len    17
>      DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, data_len);
> ...rest of function...
> #undef data_len
> }

Yes, it's not great, but I think it's better than having the length in two
places.

> 
> Thanks
> -- 
> Gustavo
> 

