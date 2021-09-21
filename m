Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FEC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 13:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4089C610E8
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 13:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhIUNr4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233384AbhIUNrz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Sep 2021 09:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632231987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvAmThRyy+RUTWUi/6d03wzJkG7ApoxnCwQT7lVpJIU=;
        b=asfj9Bh0QAQexJ6ou7rb54xrCq3IdjF9eAvZTixLN+6pmgaexMpP2Dqq97a1RN5eifQbUt
        sMxB2GT0wHKvMWhWVlfbrayl7eVRsirRWTY/vqGM9uC2c1xmMbLDYmNWLeXhwfTUzFZZEa
        46OqU3dtbhQpB2azGuQV2tRbdvvUd2Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-ulBTfEtRNj6UroeJPykEIQ-1; Tue, 21 Sep 2021 09:46:25 -0400
X-MC-Unique: ulBTfEtRNj6UroeJPykEIQ-1
Received: by mail-ed1-f72.google.com with SMTP id r23-20020a50d697000000b003d824845066so10670982edi.8
        for <linux-hardening@vger.kernel.org>; Tue, 21 Sep 2021 06:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JvAmThRyy+RUTWUi/6d03wzJkG7ApoxnCwQT7lVpJIU=;
        b=4uvO9JrBPxIZgBBZp7GtW9ByqY6uu1PpLhsPnimQyQX6/owXN+A2vatGgc0PsAAJCl
         N4S8dQyAdkgRePqb+WDIzYX1wICCXn/QPSaTbTpdsrdYYB1bRqlue6veRP3rairuqd09
         Mb9nbR8bukY5WcK92L43Vj+c55HY1JCiW7TX+sxQFO40Qup3DmNfqD2UuGu2Pmn7MomP
         ItyulYkocDAx2YL8uWLyHhlUkDwo0TISSdMZjFqNpYbx4qavha78Dj9Z02e0w9rffa88
         vrj77d9V2eZZ/cvuLcaK3eJtu+WTMSwcaGeUMzjZ8kyVktLDA0znCq1BGpddIHFxP5iU
         CDIA==
X-Gm-Message-State: AOAM532o5JjqDWFsWHczeviqklLFjMb6n2O+1UHQLTsc57raRFdPoWuT
        a4Ukoj1IIinLlPymHkIpLvhMX90rHjewt/9ESauMAEVPoc26lBuyfT2wK9+GOwZh3BPw5vY3/Zw
        89sTmVGETQxrAwGOAxvuFLXakhtcu
X-Received: by 2002:a05:6402:42d4:: with SMTP id i20mr35686284edc.348.1632231984275;
        Tue, 21 Sep 2021 06:46:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuMWC72gfkEbgCU16//CHfsCXwFHzIUTYNM/BMn7rMOz+GwSGYe5QXo4U0pKFB0Mb8mGLHOw==
X-Received: by 2002:a05:6402:42d4:: with SMTP id i20mr35686260edc.348.1632231984096;
        Tue, 21 Sep 2021 06:46:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z18sm8468335edq.29.2021.09.21.06.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 06:46:23 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Prefer struct_size over open
 coded arithmetic
To:     Kees Cook <keescook@chromium.org>, Len Baker <len.baker@gmx.com>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210918150500.21530-1-len.baker@gmx.com>
 <202109192246.B438B42EF@keescook>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ba427967-cb1b-58a8-ec93-bd5ae89f58f8@redhat.com>
Date:   Tue, 21 Sep 2021 15:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202109192246.B438B42EF@keescook>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On 9/20/21 7:58 AM, Kees Cook wrote:
> On Sat, Sep 18, 2021 at 05:05:00PM +0200, Len Baker wrote:
>> As noted in the "Deprecated Interfaces, Language Features, Attributes,
>> and Conventions" documentation [1], size calculations (especially
>> multiplication) should not be performed in memory allocator (or similar)
>> function arguments due to the risk of them overflowing. This could lead
>> to values wrapping around and a smaller allocation being made than the
>> caller was expecting. Using those allocations could lead to linear
>> overflows of heap memory and other misbehaviors.
>>
>> So, switch to flexible array member in the struct attribute_set_obj and
>> refactor the code accordingly to use the struct_size() helper instead of
>> the argument "size + count * size" in the kzalloc() function.
>>
>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>>
>> Signed-off-by: Len Baker <len.baker@gmx.com>
>> ---
>>  drivers/platform/x86/thinkpad_acpi.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>> index 50ff04c84650..ed0b01ead796 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -1008,7 +1008,7 @@ struct attribute_set {
>>
>>  struct attribute_set_obj {
>>  	struct attribute_set s;
>> -	struct attribute *a;
>> +	struct attribute *a[];
>>  } __attribute__((packed));
> 
> Whoa. I have so many questions... :)
> 
>>
>>  static struct attribute_set *create_attr_set(unsigned int max_members,
>> @@ -1020,13 +1020,11 @@ static struct attribute_set *create_attr_set(unsigned int max_members,
>>  		return NULL;
>>
>>  	/* Allocates space for implicit NULL at the end too */
>> -	sobj = kzalloc(sizeof(struct attribute_set_obj) +
>> -		    max_members * sizeof(struct attribute *),
>> -		    GFP_KERNEL);
>> +	sobj = kzalloc(struct_size(sobj, a, max_members + 1), GFP_KERNEL);
> 
> Whoa, this needs a lot more detail in the changelog if this is actually
> correct. The original code doesn't seem to match the comment? (Where is
> the +1?) So is this also a bug-fix?

Kees, at first I thought you were spot-on with this comment, but the
truth is more subtle. struct attribute_set_obj was:

struct attribute_set_obj {
        struct attribute_set s;
        struct attribute *a;
} __attribute__((packed));

Another way of looking at this, which makes things more clear is as:

struct attribute_set_obj {
        struct attribute_set s;
        struct attribute *a[1];
} __attribute__((packed));

So the sizeof(struct attribute_set_obj) in the original kzalloc call
included room for 1 "extra" pointer which is reserved for the terminating
NULL pointer.

Changing the struct to:

struct attribute_set_obj {
        struct attribute_set s;
        struct attribute *a[];
} __attribute__((packed));

Is equivalent to changing it to:

struct attribute_set_obj {
        struct attribute_set s;
        struct attribute *a[0];
} __attribute__((packed));

So the change in the struct declaration reduces the sizeof(struct attribute_set_obj)
by the size of 1 pointer, making the +1 necessary.

So AFAICT there is actually no functional change here.

Still I will hold off merging this until we agree on this :)

> (I see the caller uses +2? Why? It seems to be using each of hotkey_attributes,
> plus 1 more attr, plus a final NULL?)

The +2 is actually for 2 extra attributes (making the total number
of extra attributes +3 because the sizeof(struct attribute_set_obj)
already includes 1 extra). 

FWIW these 2 extra attributes are for devices with a
a physical rfkill on/off switch and for the device being
a convertible capable of reporting laptop- vs tablet-mode.

>>  	if (!sobj)
>>  		return NULL;
>>  	sobj->s.max_members = max_members;
>> -	sobj->s.group.attrs = &sobj->a;
>> +	sobj->s.group.attrs = sobj->a;
>>  	sobj->s.group.name = name;
> 
> The caller also never sets a name?

attribute_group.name may be NULL, I don't know
of (m)any drivers which actual set this to non NULL.

> Why is struct attribute_set_obj marked as __packed?

I have no clue, this seems completely unnecessary.

Len Baker can you submit a separate patch removing the useless
__packed ?

Regards,

Hans

