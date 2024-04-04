Received: from sxb1plsmtpa01-11.prod.sxb1.secureserver.net (sxb1plsmtpa01-11.prod.sxb1.secureserver.net [188.121.53.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1D182BB
	for <linux-hardening@vger.kernel.org>; Thu,  4 Apr 2024 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197251; cv=none; b=TQ7BfsNBhnv+mKGohhGXI+h3AJugq9vQyoYvyWweXXsI8v3TQKHebMOqa6sQPIclQNVd6lXXyoeRt2/kdHBzq7XDMJD+BEyF8Z6Esg0x1jZah+jmYkuYpbvqZlo4vptWcd1MXrDQySwth2/Z2kEtDoOXDL/7RKGAfsofUazvRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197251; c=relaxed/simple;
	bh=wkVVPzfd0UQTkvZ8xc/BmRhj+WUj2Lu/IgPhkOElz1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oc8JvM2oAOK39b/RzcDAcuIjrRbudkC2LuaHgk30HXPJwvDrIdIlPoJwVl0PZ+VhjQEdPlBmpgGwf0qwH/Mu3WsLQ+tZ2z8q9Kv6pLyddKZAELu61A1fcAaH+d+Q7hZiqzWykFwMK7N8ljAutQUqHnD54W/nxrm9Y3Eu1YCjGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.90] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id sB7er3FFsvAPUsB7frsYBM; Wed, 03 Apr 2024 17:38:32 -0700
X-CMAE-Analysis: v=2.4 cv=R+XIGsRX c=1 sm=1 tr=0 ts=660df688
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=FXvPX3liAAAA:8 a=W08pmZW3enM1sLpWauQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <356bd1ed-9877-461d-9593-bbf1b23b3d8c@squashfs.org.uk>
Date: Thu, 4 Apr 2024 01:38:30 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Squashfs: replace deprecated strncpy with strscpy
To: Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240328-strncpy-fs-squashfs-namei-c-v1-1-5c7bcbbeb675@google.com>
 <594a6365-5cc6-4778-aec5-c5ad2a4b2930@squashfs.org.uk>
 <CAFhGd8pCE11Xm219Pc8uyJnsDkSqaTM6gpY8Tpa2fWmHg4OnCA@mail.gmail.com>
Content-Language: en-GB
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <CAFhGd8pCE11Xm219Pc8uyJnsDkSqaTM6gpY8Tpa2fWmHg4OnCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBq20SukAjsHUGUSD81ZufCFLj2kOVSbjtsHJxDyR/RYet6SRJVmHlsADOcDUkZyYBBOFeMIBvOVZLXPTw3bitAkOGgGp0utu0wfwHWSvsgYAQt41tz9
 /gBKeMmU2ckl8QthIAXK4vuu+psXeUDL+R2kANNGLtgpszVHStA8bIKFxZcjOlgv7peYlopIw2CUMrOCHOZ5t8fkGohWUhYUIef3W6G5kgEJBaCvrehEtVzl
 Rpv0g2bmmvbqrpH8cnYkHl2y3QXBw/i4t0ANDDMvMAXWsw0UtE7tAxoo5kS0YO88

On 04/04/2024 01:30, Justin Stitt wrote:
> On Wed, Apr 3, 2024 at 12:32 PM Phillip Lougher <phillip@squashfs.org.uk> wrote:
>> A better way to remove the strncpy() is to remove the unnecessary string
>> copy, which I have done in this patch here:
> 
> Great! Cleaning up this code while removing strncpy() is a two for one.

Yes - thanks for your reply.

Phillip
