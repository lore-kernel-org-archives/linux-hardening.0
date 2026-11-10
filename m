Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305600;
	b=drQ03F8oAqKGvYQdvZUbmr2afomM1WtAC22TeEH9YEWhs1BYZQZbWoSBjzGfYqHriufV
	 6A/EMrfJe6NbiWf8F/hWHndCxg5gY08b7Q+Qcat202cVEFdpazOcbYv/hZN1hPVhoIc5X
	 F/FbBZ/SuGHIrcsFG0Flt+FTZ8inS/M+Gf7f9LXDmhf+d9XJJfVpPvXQfyX1bWFLwvyGo
	 yeoDVzMBtGNIDTw2SaBDm0NOzSWyVHi7nYA3RBT3a26Yc2BCTE2RiHpLhUIIwR6/3lJpA
	 JVGgmIcpFnj2FhakLiD+6Gv6m9a3MEVa2ugBZfTb844tSkuOaLHtvQV0hCV+GsXQEdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305600;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7lZki/LBL0F86IwmD+ZREFy3qnWUNsldGDK/mcimVKo=;
	b=SycYPTy5GQ0KPVWT7IhNkeYBzfsmCYauqhOcj36eNiEhJjWT4/XftNQvgBpDw4lGvqJ8
	 jEIT6Voybrn+TFoV0vKfLK4UO/ymrwysEfMyuJLQLpk2hbSzcA/qeFA7HLOYpx/hmCsmE
	 UKh679+SJcCMfFVX62OA4Gn+Ym4J+qpRTLf7LK7XagaJI6EKYTy8Sz2EL+qfhkCMe0cgM
	 g6PQf815ShM3aUnrupHw7Ehs2DOu8zB2Jr+jOm5XX2D6bzdxSTBSpwjJOGoMC30X5xHz8
	 9LwhUnK6cp4BUseMqr0hVfKK9+XyRnrI7XWrKwHWwkL7caoVs1I5I6fBvFmRtnHpXiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+nTugQx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88D606A331;
	Tue, 10 Nov 2026 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+nTugQx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484C91F008A1;
	Tue, 10 Nov 2026 10:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305599;
	bh=7lZki/LBL0F86IwmD+ZREFy3qnWUNsldGDK/mcimVKo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=R+nTugQx2Ko5IKMnMDEZYXzbne9QVOibmpJBeM4hwwgYeLhC+t8Qlw5vywGYKPCJj
	 EkMrjwUrGHpJB0yS6BHTQUjcN5n/AvRetx5szQelim7Rr4nPzQAIoqNx+cCRT6FhmT
	 qQcJo8rDDwq2nq9kxvwQjpoAEy5twIEZ4W4r1heQV3dpAa+EWJl+m+RaCRQD7naHMc
	 G/OTsRMVT4DuG8vNbf9ZFYsAp5x/7PFPpINPOo3Z4cIkyCXaJsPsTBlxuqYlqKa7wA
	 6PrTt2mfYw4eH5WDrvrHMob30PvH8bbUHYr4bFdfH2E1k4vyJ54qCLHqePZS2veXSB
	 hpnbE70gWbP4A==
Message-ID: <ed2a6a4e-f480-4b39-9684-0dbd2d55e261@kernel.org>
Date: Tue, 10 Nov 2026 11:13:16 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] media: verisilicon: Replace strlcat() with seq_buf
To: David Laight <david.laight.linux@gmail.com>,
 Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: nicolas.dufresne@collabora.com, benjamin.gaignard@collabora.com,
 p.zabel@pengutronix.de, mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com,
 morbo@google.com
References: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
 <20261108200800.2b3b15cf@pumpkin>
Content-Language: en-US, nl
In-Reply-To: <20261108200800.2b3b15cf@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2026 21:08, David Laight wrote:
> On Thu,  5 Nov 2026 00:45:18 -0800
> Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:
> 
>> In preparation for removing the deprecated strlcat() API[1], replace
>> the strscpy() and strlcat() calls with seq_buf operations when
>> constructing Hantro video device names.
>>
>> This preserves the resulting strings, including truncation
>> when the compatible string and suffix exceed the destination
>> buffer's capacity.
> 
> This is just stupid...
> 
> David
> 
>>
>> Link: https://github.com/KSPP/linux/issues/370 [1]
>> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Nacked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Just use scnprintf.

Regards,

	Hans

>> ---
>>  drivers/media/platform/verisilicon/hantro_drv.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>> index 26e5d5547466..2bfcd45cc55e 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/pm.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/seq_buf.h>
>>  #include <linux/slab.h>
>>  #include <linux/videodev2.h>
>>  #include <linux/workqueue.h>
>> @@ -883,6 +884,7 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
>>  	const struct of_device_id *match;
>>  	struct hantro_func *func;
>>  	struct video_device *vfd;
>> +	struct seq_buf s;
>>  	int ret;
>>  
>>  	match = of_match_node(of_hantro_match, vpu->dev->of_node);
>> @@ -902,9 +904,12 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
>>  	vfd->vfl_dir = VFL_DIR_M2M;
>>  	vfd->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;
>>  	vfd->ioctl_ops = &hantro_ioctl_ops;
>> -	strscpy(vfd->name, match->compatible, sizeof(vfd->name));
>> -	strlcat(vfd->name, funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ?
>> -		"-enc" : "-dec", sizeof(vfd->name));
>> +
>> +	seq_buf_init(&s, vfd->name, sizeof(vfd->name));
>> +	seq_buf_puts(&s, match->compatible);
>> +	seq_buf_puts(&s, funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ?
>> +			"-enc" : "-dec");
>> +	seq_buf_terminate(&s);
>>  
>>  	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
>>  		vpu->encoder = func;
> 
> 

