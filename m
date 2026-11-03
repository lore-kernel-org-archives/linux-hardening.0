Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713868;
	b=P62HlpNfnJa78CAXq5NXz42UKRKXOEyQASxzwRu9HmH16g83CrmE3Zae//Mon6R4Qi2W
	 0YhNKzfelexXgrqaZFu3x97A65gl1IBvL94VawxPJhD5aZE4/CfgvvFbYbGGKXW66ojox
	 g1uwsVujJd9TrhOW6VfSfMjDJDgMKPGg9QfroXxE/CRrfhmFrhY7bIOPotxvKHy7C913/
	 IAiLOChRfpSHd4T8MKNUA3vvKd+/okoXunU52xuJs41A1JjwKjIlJQSpMZ+CNn3YK3g0p
	 x46CcZZv+Us9jzRZB0ElOYOPIXCydlHWuzLCy8wnKTDjZ1ZqDpq4sVsCdB+/oUAOANQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713868;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=kAZHHRNJQTBE7m/Mdeu3wvd8YYTG4G1JA7sRIt/FlQI=;
	b=JoXQa7V9efIY69d1EUlYI/NRRqAinAEgAH8BaMzA7w7ZISoEe9gj+nYof+rGa+22mUP4
	 Wc5TVnPxLEeETLaNvESqGJ9YaxU7sIyNgC7J7Zih7Ab7ifs5pXJY3LMU7hoB8jnodLk3D
	 BeqAjZRqyDi6aWkSnuauOyvWDHxjva9Sy09IOAYBrQWo+NBO6D0WT7WN/pAJ5efdGNGGm
	 ZERtT4WCoH6SPd61AIQc+6qP9633pGHEe3nNiQ71jYz9cN2zF4ir89N2IEMEYup2b9XkM
	 iC/nB7KFm5fMx0cVJeic9Z2/gKLGIFkOvzGsS4FDFVHP52dEPjKffwhSP3mW/rxdusg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IY8HlU3W;
	arc=none smtp.remote-ip=74.125.82.228
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E036083607
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E036083607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IY8HlU3W
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-3535a54bed9so6234801eec.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713867; x=1794318667;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kAZHHRNJQTBE7m/Mdeu3wvd8YYTG4G1JA7sRIt/FlQI=;
        b=n6ghJtf3oVEw98UFfUURwLOIcy+PHPBkhJKRzVS4mCK8E/U2vQxKFm2D50xjd/N6EQ
         F2NLfAHERquP/t3jIHiTf8jYnMLiBWxk0V9CVz+JNLaRhH1Iwtb85VrO3Rx3HAr3nh+G
         p3o1kdsb620OIVN0rI12h4CwYCqxc5py38nAmMyrjVqjWbYXJlmllWnn0ZvrLRYg21nQ
         NkLboX8CmfZlnMU7pY0M1t6GFwNYYrqLN5VWWPHr2rCnP/77Ch/Yc62zxpctclZrh1b3
         uFgD7jRlqOVN9c++w3N3gwf3K4gShb0XDaTnJEoiAy/qb4TCQDVfGV8WEOG+kmyylSrr
         SLyg==
X-Forwarded-Encrypted: i=1; AKwUvByvwpCmgsCU3wpePqZ5WA1d10WN1G6ViBQ4Q03wuYh/th+MBFMvnPIcDqN/SeSZzyzjYjFXiqBTiW1i0KSvPOU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CvQ7Q94RVbIodeqAkrZ/leZWp8NF6w5A5mOWvQuN6Tc+R0hD1
	2+pIeRznFyDE076pCIkWNUcMchdmY3tQkEO0ohLdiwYk7jtoGrN7EUgdpaDCHKl84GTZurwSjJF
	5mE6gzj3CkyQA2M52aw2JrUDxWjOPjzzZHDKopp63/vRSXlKxACbsn35+2AcD7kNXrp0wWCmJqp
	f1l0sbMWpt/9p7vMotpgRk2OSWX40jCDm7iD7jeE/qif1LAR6z78WGxn04an6aq3ywabZd3E2Wn
	JVhY2m9mat0J2pagPvgcd5f1DM9kw==
X-Gm-Gg: AYBFou1IAXShwZmJv8Z/8yU7LDy/y/qaEGOJYhV6PEc0kB4d0ZtIU3WBldgtuXopLe+
	edzqQ+wlsz6EEDK+/k88+TBbyc4mz73ZOJY0Btm/M7ATzuge1JSlGXh+0A1NbopGx7yNe464gLw
	gO37h1K8GCA9TQT/aBCLCyqgOJvTzHE6/FCrpfpMEQn81gDgbT3csUGaOKLUQXl7SAoX6RGFXAE
	kxnbngb0gJZjpXn5HvAyz4zzDAOst5n29gv8Ag8nZtCOQZZRtNjtMQPweA8+5SGyPFGtzUb4sH6
	teFUgmEbGWub0xW8q4Jvj+SGfSuZi9ZJZhqRe/U3PHi2uaK0Uju0xjDAPoFYEM++iVTkoGNgSd3
	E9vu67NQe2Mzxwx+Dqrg+ZhMSfIK9zjOWEmlic8gViLPI2O8xU1OyoPZXoE2+tDLxCEMI6Rpz/i
	VOfgbbbmiyAvfyje1fufJSd+1IfJ2Cti1z6qoV6V8=
X-Received: by 2002:a05:7300:5786:b0:36c:3b8a:8090 with SMTP id 5a478bee46e88-36c3b8a842amr3104012eec.2.1793713866880;
        Tue, 03 Nov 2026 05:51:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-36a42877874sm130511eec.15.2026.11.03.05.51.06
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:51:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5338ff2cf14so81572351cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793713865; x=1794318665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAZHHRNJQTBE7m/Mdeu3wvd8YYTG4G1JA7sRIt/FlQI=;
        b=IY8HlU3WxUDePY2105RkzMhKUipiohAFAr6U/x1iS19f5qa9jwLwhARxMrjMckEz6I
         +JEG6N89TD2IMttxY9WgdpqqBSKBgbNYGROHJCMO8JmiaePzOqkkzkac7Ib05qSGJrBZ
         DEdTMnnXr91GSBvrCeL6s5crRSOQMEycex6N8=
X-Forwarded-Encrypted: i=1; AKwUvBxYFKVoC8WplYKQ6bbdJlDIdTpLVOIJCZSNX0lSUgoNtfLA0sAc4TEUKnmmBtHf5P7MjdFz/pJZw0XkPais5HE=@vger.kernel.org
X-Received: by 2002:ac8:5a4a:0:b0:535:84e3:ceef with SMTP id d75a77b69052e-542b781c626mr217069881cf.45.1793713865367;
        Tue, 03 Nov 2026 05:51:05 -0800 (PST)
X-Received: by 2002:ac8:5a4a:0:b0:535:84e3:ceef with SMTP id d75a77b69052e-542b781c626mr217069361cf.45.1793713864762;
        Tue, 03 Nov 2026 05:51:04 -0800 (PST)
Received: from [10.176.3.155] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e77e5efc3sm870636d6.39.2026.11.03.05.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:51:03 -0800 (PST)
Message-ID: <533b31e4-c837-494d-a4ce-a728bfbe07b2@broadcom.com>
Date: Tue, 3 Nov 2026 14:51:00 +0100
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
Subject: Re: [PATCH 00/13] wifi: brcmfmac: Add BCM4388 support
To: Janne Grunau <j@jannau.net>
Cc: michael.reeves077@gmail.com, Pieter-Paul Giesberts
 <pieterpg@broadcom.com>, "Franky Lin (Zhenhui)" <frankyl@broadcom.com>,
 Mathy Vanhoef <vanhoefm@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, asahi@lists.linux.dev,
 Hector Martin <marcan@marcan.st>, Daniel Berlin <dberlin@dberlin.org>,
 linux-kernel@vger.kernel.org, Hante Meuleman <meuleman@broadcom.com>,
 linux-hardening@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
 Izabela Bakollari <ibakolla@redhat.com>
References: <20260925-brcm4388-submit-v1-0-b5cbc2cde2fb@gmail.com>
 <d78cbbd2-601a-4cf1-800f-3be57a2b7de2@broadcom.com>
 <20261102204627.GB770347@robin.jannau.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20261102204627.GB770347@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 02/11/2026 21:46, Janne Grunau wrote:
> On Sun, Nov 01, 2026 at 08:27:22PM +0100, Arend van Spriel wrote:
>> + Peter, Izabela
>>
>> On 25/09/2026 15:43, Michael Reeves via B4 Relay wrote:
>>> The Broadcom BCM4388 chipset requires new PCIe initialization and
>>> firmware interfaces. Add support for these interfaces to brcmfmac to
>>> enable basic station operation.
>>>
>>> This series adds:
>>> - Signed firmware loading and mailbox transport
>>> - Fixes for chip identification and firmware capability matching
>>> - Versioned scan and join requests, and extended PMK payloads
>>> - Updated event mask handling
>>>
>>> These changes include work by Hector Martin and Daniel Berlin from Asahi
>>> Linux, refactored where needed for upstream inclusion.
>>>
>>> The series provides basic station support only. 6 GHz support is planned
>>> for a follow-up patchset after this lands. The driver retains legacy
>>> interfaces for older firmware.
>>>
>>> Tested on an Apple M3 MacBook Air (J613):
>>> - Device boot and network scanning
>>> - 5 GHz WPA2-PSK association and DHCP
>>> - Bidirectional TCP traffic
>>
>> Finally got some time to get this series tested on my setup. The patches
>> generally look good. So far no regressions observed. It would be good if
>> some more people could test this series on their equipment. I will do
>> some more testing and wait some days.
> 
> Tested series on top of v7.3 + commit 7ed5dce55fa8 ("wifi: brcmfmac: map
> msgbuf RX packet IDs bidirectional") in wireless/main with resolving the
> conflict by dropping the conflicting hunk of this series.
> 
> Tested on Mac mini (M1, BCM4378) and Macbook Pro 14-inch (M1 Max,
> BCM4387) without regressions (except for the resolved RX msgbuf
> mapping).
> 
> Tested-by: Janne Grunau <j@jannau.net>
No regressions seen on my 43664 and 43455 devices. So will process the 
patches now.

Regards,
Arend
