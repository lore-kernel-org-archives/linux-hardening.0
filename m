Received: from smtp113.iad3b.emailsrvr.com (smtp113.iad3b.emailsrvr.com [146.20.161.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8BB49A3BD
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590896; cv=none; b=WpH9BtyvWqf3OaHWgZEpjBDoJWrVia7bvm5ZbA/7hMfhZ5mlIHHhS8Ruw3thcF3HEqywsxfr26zLzLGoHFSgpsoCWsxQ8+6GnCHTLlUUx6DPhGq1uWdgt1NUm3mt7XE8ABrwgai7N76bF42+KfyBx5AH4uXkCvSaFNtsn2gvack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590896; c=relaxed/simple;
	bh=Y7Qw7W5qMjGxVfGumDi7SR3QDvt0n6QdbufdrETuCeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEuKXp1QTjqsFQW0sUiSPZxvLuTGzN48IuqaeScHEoEzor7yFUqSUda+aILGneQbYaAY4ei0SscZFRWf7bJ9b9bH86pDZDOTlWCoJHbN/+s3K8LdmdDphLkLYKUTRVWC1NHuCTLY8DhtFchrSZodfP/alXfGn56yttrM204A7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b=NTeJ7+nx; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=aw8T3DXu; arc=none smtp.client-ip=146.20.161.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="NTeJ7+nx";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="aw8T3DXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
	s=feedback; t=1790589733;
	bh=Y7Qw7W5qMjGxVfGumDi7SR3QDvt0n6QdbufdrETuCeM=;
	h=Date:Subject:To:From:From;
	b=NTeJ7+nxk76Lecl3m6v/Ega4DT/rvEqWbWT+tqdBD+DYjPT8LcD/SUm6Chw8yh1i1
	 w3e81q00njwFoGLSwmTNFTk5tI7zVZAu23ty3HF3jd02AtSYo8RNtKJFwD9QBGyPjM
	 AJNw3TgIEYlioyKMzEV3YoYAdP9RSdjMI6mJ4wUI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1790589733;
	bh=Y7Qw7W5qMjGxVfGumDi7SR3QDvt0n6QdbufdrETuCeM=;
	h=Date:Subject:To:From:From;
	b=aw8T3DXu1MUnWKIgIPGGedkDvOoZfOFAP9ZXkieQYI9CeJBmqTdASpyednGgMn7hz
	 6jlC77Qo17cjniY3kMbGlgxKekU9RfDwVVqUeE6LVgTP02wMoeGS/UYCZsP+zBc+lF
	 HR9PfawWeeQxMDa7F0DxVjd6tDlqtcaL2Ehtllc8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E3EF5600BF;
	Mon, 28 Sep 2026 06:02:12 -0400 (EDT)
Message-ID: <998d8eab-5a4b-4e5d-9844-16022d571d18@mev.co.uk>
Date: Mon, 28 Sep 2026 11:02:11 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: comedi_bond: Refactor strlcat() to seq_buf in
 do_dev_config()
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>, hsweeten@visionengravers.com
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 morbo@google.com, kees@kernel.org, justinstitt@google.com,
 codemender-patching+linux@google.com
References: <20260927060000.518354-1-nikitash.mariiaw@gmail.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20260927060000.518354-1-nikitash.mariiaw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 2b9ad3f3-7b10-40dd-b0b5-dd7844833867-1-1

On 27/09/2026 07:00, Mariia Nikitash wrote:
> From: Bill Wendling <morbo@google.com>
> 
> do_dev_config() builds a space-separated list of bonded devices in
> devpriv->name by formatting each "minor:subdev " pair into a temporary
> stack buffer with snprintf() and appending it with strlcat() in a loop.
> 
> In preparation for removing the deprecated strlcat() API[1], use struct
> seq_buf and seq_buf_printf() to format each entry directly into
> devpriv->name. This avoids repeated rescanning of devpriv->name and
> eliminates the temporary buffer.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> ---
>   drivers/comedi/drivers/comedi_bond.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/comedi_bond.c
> index 8e10ecab4f0d..a10cfbd04c72 100644
> --- a/drivers/comedi/drivers/comedi_bond.c
> +++ b/drivers/comedi/drivers/comedi_bond.c
> @@ -39,6 +39,7 @@
>   
>   #include <linux/module.h>
>   #include <linux/string.h>
> +#include <linux/seq_buf.h>
>   #include <linux/slab.h>
>   #include <linux/comedi.h>
>   #include <linux/comedi/comedilib.h>
> @@ -170,10 +171,11 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
>   {
>   	struct comedi_bond_private *devpriv = dev->private;
>   	DECLARE_BITMAP(devs_opened, COMEDI_NUM_BOARD_MINORS);
> +	struct seq_buf s;
>   	int i;
>   
>   	memset(&devs_opened, 0, sizeof(devs_opened));
> -	devpriv->name[0] = 0;
> +	seq_buf_init(&s, devpriv->name, sizeof(devpriv->name));
>   	/*
>   	 * Loop through all comedi devices specified on the command-line,
>   	 * building our device list.
> @@ -250,15 +252,9 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
>   			}
>   			devpriv->devs = devs;
>   			devpriv->devs[devpriv->ndevs++] = bdev;
> -			{
> -				/* Append dev:subdev to devpriv->name */
> -				char buf[20];
> -
> -				snprintf(buf, sizeof(buf), "%u:%u ",
> -					 bdev->minor, bdev->subdev);
> -				strlcat(devpriv->name, buf,
> -					sizeof(devpriv->name));
> -			}
> +
> +			/* Append dev:subdev to devpriv->name */
> +			seq_buf_printf(&s, "%u:%u ", bdev->minor, bdev->subdev);
>   		}
>   	}
>   
> @@ -267,6 +263,8 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
>   		return -EINVAL;
>   	}
>   
> +	seq_buf_str(&s);
> +
>   	return 0;
>   }
>   

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
