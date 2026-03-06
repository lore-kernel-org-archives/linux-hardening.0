Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33436EAA5
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823263; cv=none; b=iWh518R2NvgnBdU7Wvj0Al6k1F6LoSDKRCMsj48lrI7zjwkbbJoftfZ9wg3+YBS4nWecN/3GDqRtupJTmv9MZfcB114WI3XQeQpl0etx01DYkT93ezuOQh4G30fdHG9pUDTanoQvU8wjZyIY5Irv51o/pOD6EtEtJiLVgUhyQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823263; c=relaxed/simple;
	bh=3l6axKbntefNBNgasKFf9eLo6XFZId1HJ0Th4Igut9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M69kBO+OX/3yMWQvwuCyL5q2L6vjbtmkK1whg+6etRZunXizhl8UOKjQ6rwINIpPPpOgb/aaK9v9G1Ge+VAOmjHI+gdRG1JhMlJnbwoGngsdf1dqF7LeZpHqR2FJswQZkyJTyWmme307mzNfeoaTT00gvyiP/CUHe2nTCa5Qca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=rEds6i2a; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="rEds6i2a"
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id yWeqv2IgrCxrGyaJTvws4C; Fri, 06 Mar 2026 18:54:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id yaJQvjHNecu11yaJQv3A5j; Fri, 06 Mar 2026 18:54:12 +0000
X-Authority-Analysis: v=2.4 cv=bKYWIO+Z c=1 sm=1 tr=0 ts=69ab22d7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=Y9novZUF53J6TEI7N0YA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N2ZGgiIxstN9ddSFJ9TuTpNAOos5JnaKJWqWEDoDITc=; b=rEds6i2a/eiBoSa86IneISGdXO
	Col85M6u8yZLZIyLkcMJBsNrWLfiVTzk1uVFoyo8I1q6e3aYxsINXHpHtNXrpxXlMyffoI1qyU1ku
	aL0AuuXaAS7iMenxH+DfK3/q/s0dxFYSb+2E083CrzE7QW2tBA4y/zJebFYyf98qCZ1NR5y6+Nve3
	toe9j47d/E+DnY/dTKpaM6O8gYthoI+ZUS/cTZJmjIksWBXwBHq75sG7/vfrOV9a7NczbFwRnItzE
	y31EWEGNKukbkXHm9UvAZaeCh8XF26IAE7UQTFKN+T2TXZuUvtK5s7+erAu0LcTXhI3mw/Gl8ffZc
	lvkcROxw==;
Received: from [177.238.16.13] (port=47446 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vyaJP-00000000k3w-2pb9;
	Fri, 06 Mar 2026 12:54:11 -0600
Message-ID: <be17111e-1c78-49ca-8bae-fadcd7af6905@embeddedor.com>
Date: Fri, 6 Mar 2026 12:53:39 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: tcpm: kzalloc + kcalloc to kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-usb@vger.kernel.org
Cc: Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260306031639.46942-1-rosenp@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260306031639.46942-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1vyaJP-00000000k3w-2pb9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:47446
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfArGfIcMTUaWbGUOOuv4e7Do4UA+SMZIu7YzbnpuP25y8aBi6iohqvpFOu3NHp91uVYfK7H3Ru9p9GK3KPefpkuocrjWVMH7CHDf9nFXXISwyy/lAkKw
 MlqaB7SWTB4+brwDJF5GBu9GEWsDMPIuNXSWuiRtu9xTI6h1Eq0Nmfp/dUoEnCWApJ3WEfaN6Ahw6Sid5By9saD4T3+70L6qY0DmyViOTt1shbS3I+JLu0jf



On 3/6/26 12:16, Rosen Penev wrote:
> Simplifies allocation and allows using __counted_by for extra runtime
> analysis.

Are you finding these with Coccinelle or any other tool?

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 1d2f3af034c5..272f9187b12d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -605,9 +605,9 @@ struct altmode_vdm_event {
>   	struct kthread_work work;
>   	struct tcpm_port *port;
>   	u32 header;
> -	u32 *data;
>   	int cnt;
>   	enum tcpm_transmit_type tx_sop_type;
> +	u32 data[] __counted_by(cnt);
>   };
>   
>   static const char * const pd_rev[] = {
> @@ -1653,7 +1653,6 @@ static void tcpm_queue_vdm_work(struct kthread_work *work)
>   	tcpm_queue_vdm(port, event->header, event->data, event->cnt, event->tx_sop_type);
>   
>   port_unlock:
> -	kfree(event->data);
>   	kfree(event);
>   	mutex_unlock(&port->lock);
>   }
> @@ -1662,35 +1661,27 @@ static int tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
>   				   const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
>   {
>   	struct altmode_vdm_event *event;
> -	u32 *data_cpy;
>   	int ret = -ENOMEM;
>   
> -	event = kzalloc_obj(*event);
> +	event = kzalloc_flex(*event, data, cnt);
>   	if (!event)
>   		goto err_event;
>   
> -	data_cpy = kcalloc(cnt, sizeof(u32), GFP_KERNEL);
> -	if (!data_cpy)
> -		goto err_data;
> -
>   	kthread_init_work(&event->work, tcpm_queue_vdm_work);
> +	event->cnt = cnt;
>   	event->port = port;
>   	event->header = header;
> -	memcpy(data_cpy, data, sizeof(u32) * cnt);
> -	event->data = data_cpy;
> -	event->cnt = cnt;
> +	memcpy(event->data, data, sizeof(u32) * cnt);
>   	event->tx_sop_type = tx_sop_type;
>   
>   	ret = kthread_queue_work(port->wq, &event->work);
>   	if (!ret) {
>   		ret = -EBUSY;
> -		goto err_queue;
> +		goto err_data;
>   	}
>   
>   	return 0;
>   
> -err_queue:
> -	kfree(data_cpy);
>   err_data:
>   	kfree(event);
>   err_event:

